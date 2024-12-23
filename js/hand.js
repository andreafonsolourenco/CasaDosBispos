var HANDJS = HANDJS || {};

(function () {
    // If the user agent already supports Pointer Events, do nothing
    if (window.PointerEvent)
        return;

    // Polyfilling indexOf for old browsers
    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function (searchElement) {
            var t = Object(this);
            var len = t.length >>> 0;
            if (len === 0) {
                return -1;
            }
            var n = 0;
            if (arguments.length > 0) {
                n = Number(arguments[1]);
                if (n !== n) { // shortcut for verifying if it's NaN
                    n = 0;
                } else if (n !== 0 && n !== Infinity && n !== -Infinity) {
                    n = (n > 0 || -1) * Math.floor(Math.abs(n));
                }
            }
            if (n >= len) {
                return -1;
            }
            var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
            for (; k < len; k++) {
                if (k in t && t[k] === searchElement) {
                    return k;
                }
            }
            return -1;
        };
    }
    //Polyfilling forEach for old browsers
    if (!Array.prototype.forEach) {
        Array.prototype.forEach = function (method, thisArg) {
            if (!this || !(method instanceof Function))
                throw new TypeError();
            for (var i = 0; i < this.length; i++)
                method.call(thisArg, this[i], i, this);
        };
    }
    // Polyfilling trim for old browsers
    if (!String.prototype.trim) {
        String.prototype.trim = function () {
            return this.replace(/^\s+|\s+$/, '');
        };
    }
    if (!Object.assign) {
        Object.assign = function (target) {
            for (var i = 1; i < arguments.length; i++) {
                for (var prop in arguments[i]) {
                    target[prop] = arguments[i][prop];
                }
            }
            return target;
        }
    }

    // Installing Hand.js
    var supportedEventsNames = ["pointerdown", "pointerup", "pointermove", "pointerover", "pointerout", "pointercancel", "pointerenter", "pointerleave"];
    var upperCaseEventsNames = ["PointerDown", "PointerUp", "PointerMove", "PointerOver", "PointerOut", "PointerCancel", "PointerEnter", "PointerLeave"];

    var POINTER_TYPE_TOUCH = "touch";
    var POINTER_TYPE_PEN = "pen";
    var POINTER_TYPE_MOUSE = "mouse";

    var previousTargets = {};
    var defaultPreventions = {};

    var checkPreventDefault = function (node) {
        while (node && !node.handjs_forcePreventDefault && getComputedStyle(node).touchAction !== "none") {
            node = node.parentElement;
        }
        return node;
    };

    // Touch events
    var generateTouchClonedEvent = function (sourceEvent, newName, overrides) {
        // Considering touch events are almost like super mouse events
        var evObj;

        if (!overrides) overrides = {};

        var buttons = ("buttons" in overrides) ? overrides.buttons : sourceEvent.buttons;

        if (window.MouseEvent && typeof MouseEvent.constructor.prototype === "function") {
            evObj = new MouseEvent(newName, {
                bubbles: overrides.bubbles,
                cancelable: true,
                view: window,
                detail: 1,
                screenX: sourceEvent.screenX,
                screenY: sourceEvent.screenY,
                clientX: sourceEvent.clientX,
                clientY: sourceEvent.clientY,
                ctrlKey: sourceEvent.ctrlKey,
                altKey: sourceEvent.altKey,
                shiftKey: sourceEvent.shiftKey,
                metaKey: sourceEvent.metaKey,
                button: sourceEvent.button,
                buttons: buttons,
                relatedTarget: overrides.relatedTarget || sourceEvent.relatedTarget
            });
        }
        else if (document.createEvent) {
            evObj = document.createEvent('MouseEvents');
            evObj.initMouseEvent(newName, overrides.bubbles, true, window, 1, sourceEvent.screenX, sourceEvent.screenY,
                sourceEvent.clientX, sourceEvent.clientY, sourceEvent.ctrlKey, sourceEvent.altKey,
                sourceEvent.shiftKey, sourceEvent.metaKey, sourceEvent.button, overrides.relatedTarget || sourceEvent.relatedTarget);
            evObj.buttons = buttons;
        }
        else {
            evObj = document.createEventObject();
            evObj.screenX = sourceEvent.screenX;
            evObj.screenY = sourceEvent.screenY;
            evObj.clientX = sourceEvent.clientX;
            evObj.clientY = sourceEvent.clientY;
            evObj.ctrlKey = sourceEvent.ctrlKey;
            evObj.altKey = sourceEvent.altKey;
            evObj.shiftKey = sourceEvent.shiftKey;
            evObj.metaKey = sourceEvent.metaKey;
            evObj.button = sourceEvent.button;
            evObj.relatedTarget = overrides.relatedTarget || sourceEvent.relatedTarget;
            evObj.buttons = buttons;
        }
        // offsets
        if (evObj.offsetX === undefined) {
            if (sourceEvent.offsetX !== undefined) {

                // For Opera which creates readonly properties
                if (Object && Object.defineProperty !== undefined) {
                    Object.defineProperty(evObj, "offsetX", {
                        writable: true
                    });
                    Object.defineProperty(evObj, "offsetY", {
                        writable: true
                    });
                }

                evObj.offsetX = sourceEvent.offsetX;
                evObj.offsetY = sourceEvent.offsetY;
            } else if (Object && Object.defineProperty !== undefined) {
                Object.defineProperty(evObj, "offsetX", {
                    get: function () {
                        if (this.currentTarget && this.currentTarget.offsetLeft) {
                            return sourceEvent.clientX - this.currentTarget.offsetLeft;
                        }
                        return sourceEvent.clientX;
                    }
                });
                Object.defineProperty(evObj, "offsetY", {
                    get: function () {
                        if (this.currentTarget && this.currentTarget.offsetTop) {
                            return sourceEvent.clientY - this.currentTarget.offsetTop;
                        }
                        return sourceEvent.clientY;
                    }
                });
            }
            else if (sourceEvent.layerX !== undefined) {
                evObj.offsetX = sourceEvent.layerX - sourceEvent.currentTarget.offsetLeft;
                evObj.offsetY = sourceEvent.layerY - sourceEvent.currentTarget.offsetTop;
            }
        }

        // adding missing properties

        if (sourceEvent.isPrimary !== undefined)
            evObj.isPrimary = sourceEvent.isPrimary;
        else
            evObj.isPrimary = true;

        if (sourceEvent.pressure)
            evObj.pressure = sourceEvent.pressure;
        else {
            var button = 0;

            if (buttons !== undefined)
                button = buttons;
            else if (sourceEvent.which !== undefined)
                button = sourceEvent.which;
            else if (sourceEvent.button !== undefined) {
                button = sourceEvent.button;
            }
            evObj.pressure = (button === 0) ? 0 : 0.5;
        }


        evObj.rotation = sourceEvent.rotation || 0;

        // Timestamp
        evObj.hwTimestamp = sourceEvent.hwTimestamp || 0;

        // Tilts
        evObj.tiltX = sourceEvent.tiltX || 0;
        evObj.tiltY = sourceEvent.tiltY || 0;

        // Width and Height
        evObj.height = sourceEvent.height || sourceEvent.radiusX || 0;
        evObj.width = sourceEvent.width || sourceEvent.radiusY || 0;

        // preventDefault
        evObj.preventDefault = function () {
            if (sourceEvent.preventDefault !== undefined)
                sourceEvent.preventDefault();
        };

        // stopPropagation
        if (evObj.stopPropagation !== undefined) {
            var current = evObj.stopPropagation;
            evObj.stopPropagation = function () {
                if (sourceEvent.stopPropagation !== undefined)
                    sourceEvent.stopPropagation();
                current.call(this);
            };
        }

        // Pointer values
        evObj.pointerId = sourceEvent.pointerId;
        evObj.pointerType = sourceEvent.pointerType;

        switch (evObj.pointerType) {// Old spec version check
            case 2:
                evObj.pointerType = POINTER_TYPE_TOUCH;
                break;
            case 3:
                evObj.pointerType = POINTER_TYPE_PEN;
                break;
            case 4:
                evObj.pointerType = POINTER_TYPE_MOUSE;
                break;
        }

        // Fire event
        if (overrides.target)
            overrides.target.dispatchEvent(evObj);
        else if (sourceEvent.target) {
            sourceEvent.target.dispatchEvent(evObj);
        } else {
            sourceEvent.srcElement.fireEvent("on" + getMouseEquivalentEventName(newName), evObj); // We must fallback to mouse event for very old browsers
        }
    };

    var generateMouseProxy = function (evt, eventName, overrides) {
        evt.pointerId = 1;
        evt.pointerType = POINTER_TYPE_MOUSE;
        generateTouchClonedEvent(evt, eventName, overrides);
    };

    var generateTouchEventProxy = function (name, touchPoint, target, eventObject, overrides) {
        var touchPointId = touchPoint.identifier + 2; // Just to not override mouse id

        touchPoint.pointerId = touchPointId;
        touchPoint.pointerType = POINTER_TYPE_TOUCH;
        touchPoint.currentTarget = target;

        if (eventObject.preventDefault !== undefined) {
            touchPoint.preventDefault = function () {
                eventObject.preventDefault();
            };
        }

        generateTouchClonedEvent(touchPoint, name, Object.assign(overrides || {}, { target: target }));
    };

    var checkEventRegistration = function (node, eventName) {
        return node.__handjsEventTunnels && node.__handjsEventTunnels[eventName] && node.__handjsEventTunnels[eventName].registrations > 0;
    };
    var findEventRegisteredNode = function (node, eventName) {
        while (node && !checkEventRegistration(node, eventName))
            node = node.parentNode;
        if (node)
            return node;
        else if (checkEventRegistration(window, eventName))
            return window;
    };

    var generateTouchEventProxyIfRegistered = function (eventName, touchPoint, target, eventObject, overrides) { // Check if user registered this event
        if (findEventRegisteredNode(target, eventName)) {
            generateTouchEventProxy(eventName, touchPoint, target, eventObject, overrides);
        }
    };

    var getMouseEquivalentEventName = function (eventName) {
        return eventName.toLowerCase().replace("pointer", "mouse");
    };

    var getPrefixEventName = function (prefix, eventName) {
        var upperCaseIndex = supportedEventsNames.indexOf(eventName);
        var newEventName = prefix + upperCaseEventsNames[upperCaseIndex];

        return newEventName;
    };

    var getEventTunnelInfo = function (item, eventName) {
        if (!item.__handjsEventTunnels) {
            item.__handjsEventTunnels = {};
        }
        if (!item.__handjsEventTunnels[eventName]) {
            item.__handjsEventTunnels[eventName] = { registrations: 0, core: null, departure: null };
        }
        return item.__handjsEventTunnels[eventName];
    }
    var subscribeManagedEventTunnel = function (item, eventName, tunnelEventName, eventGenerator) {
        var tunnel = getEventTunnelInfo(item, eventName);
        tunnel.registrations++;

        if (tunnel.core) {
            return;
        }

        // Add pointerenter/leave event tunnel
        tunnel.core = function (evt) { if (!touching) eventGenerator(evt, eventName); };
        tunnel.departure = tunnelEventName;
        item.addEventListener(tunnelEventName, tunnel.core);
    }
    var unsubscribeManagedEventTunnel = function (item, eventName) {
        var tunnel = getEventTunnelInfo(item, eventName);
        tunnel.registrations--;

        if (tunnel.registrations > 0) {
            return;
        }
        if (!tunnel.core) {
            // Unsubscription before any subscription
            tunnel.registrations = 0;
            return;
        }

        // Remove pointerenter/leave event tunnel
        item.removeEventListener(tunnel.departure, tunnel.core);
        tunnel.core = tunnel.departure = null;
    }

    var setTouchAware = function (item, eventName, enable) {
        var nameGenerator;
        var eventGenerator;
        if (window.MSPointerEvent) {
            nameGenerator = function (name) { return getPrefixEventName("MS", name); };
            eventGenerator = generateTouchClonedEvent;
        }
        else {
            nameGenerator = getMouseEquivalentEventName;
            eventGenerator = generateMouseProxy;
        }
        switch (eventName) {
            case "pointerenter":
            case "pointerleave":
                var targetEvent = nameGenerator(eventName);
                if (item['on' + targetEvent.toLowerCase()] !== undefined) {
                    if (enable) {
                        subscribeManagedEventTunnel(item, eventName, targetEvent, eventGenerator);
                    }
                    else {
                        unsubscribeManagedEventTunnel(item, eventName);
                    }
                }
                break;
            default:
                var tunnelInfo = getEventTunnelInfo(item, eventName);
                if (enable) {
                    tunnelInfo.registrations++;
                }
                else {
                    tunnelInfo.registrations = Math.max(tunnelInfo.registrations - 1, 0);
                }
                break;
        }
    };

    // Intercept addEventListener calls by changing the prototype
    var interceptAddEventListener = function (root) {
        var current = root.prototype ? root.prototype.addEventListener : root.addEventListener;

        var customAddEventListener = function (name, func, capture) {
            // Branch when a PointerXXX is used
            if (supportedEventsNames.indexOf(name) !== -1) {
                setTouchAware(this, name, true);
            }

            if (current === undefined) {
                this.attachEvent("on" + getMouseEquivalentEventName(name), func);
            } else {
                current.call(this, name, func, capture);
            }
        };

        if (root.prototype) {
            root.prototype.addEventListener = customAddEventListener;
        } else {
            root.addEventListener = customAddEventListener;
        }
    };

    // Intercept removeEventListener calls by changing the prototype
    var interceptRemoveEventListener = function (root) {
        var current = root.prototype ? root.prototype.removeEventListener : root.removeEventListener;

        var customRemoveEventListener = function (name, func, capture) {
            // Release when a PointerXXX is used
            if (supportedEventsNames.indexOf(name) !== -1) {
                setTouchAware(this, name, false);
            }

            if (current === undefined) {
                this.detachEvent("on" + getMouseEquivalentEventName(name), func);
            } else {
                current.call(this, name, func, capture);
            }
        };
        if (root.prototype) {
            root.prototype.removeEventListener = customRemoveEventListener;
        } else {
            root.removeEventListener = customRemoveEventListener;
        }
    };

    // Hooks
    interceptAddEventListener(window);
    interceptAddEventListener(window.HTMLElement || window.Element);
    interceptAddEventListener(document);
    if (!navigator.isCocoonJS) {
        interceptAddEventListener(HTMLBodyElement);
        interceptAddEventListener(HTMLDivElement);
        interceptAddEventListener(HTMLImageElement);
        interceptAddEventListener(HTMLUListElement);
        interceptAddEventListener(HTMLAnchorElement);
        interceptAddEventListener(HTMLLIElement);
        interceptAddEventListener(HTMLTableElement);
        if (window.HTMLSpanElement) {
            interceptAddEventListener(HTMLSpanElement);
        }
    }
    if (window.HTMLCanvasElement) {
        interceptAddEventListener(HTMLCanvasElement);
    }
    if (!navigator.isCocoonJS && window.SVGElement) {
        interceptAddEventListener(SVGElement);
    }

    interceptRemoveEventListener(window);
    interceptRemoveEventListener(window.HTMLElement || window.Element);
    interceptRemoveEventListener(document);
    if (!navigator.isCocoonJS) {
        interceptRemoveEventListener(HTMLBodyElement);
        interceptRemoveEventListener(HTMLDivElement);
        interceptRemoveEventListener(HTMLImageElement);
        interceptRemoveEventListener(HTMLUListElement);
        interceptRemoveEventListener(HTMLAnchorElement);
        interceptRemoveEventListener(HTMLLIElement);
        interceptRemoveEventListener(HTMLTableElement);
        if (window.HTMLSpanElement) {
            interceptRemoveEventListener(HTMLSpanElement);
        }
    }
    if (window.HTMLCanvasElement) {
        interceptRemoveEventListener(HTMLCanvasElement);
    }
    if (!navigator.isCocoonJS && window.SVGElement) {
        interceptRemoveEventListener(SVGElement);
    }

    // Prevent mouse event from being dispatched after Touch Events action
    var touching = false;
    var touchTimer = -1;

    function setTouchTimer() {
        touching = true;
        clearTimeout(touchTimer);
        touchTimer = setTimeout(function () {
            touching = false;
        }, 700);
        // 1. Mobile browsers dispatch mouse events 300ms after touchend
        // 2. Chrome for Android dispatch mousedown for long-touch about 650ms
        // Result: Blocking Mouse Events for 700ms.
    }

    function getFirstCommonNode(x, y) {
        while (x) {
            if (x.contains(y))
                return x;
            x = x.parentNode;
        }
        return null;
    }

    //generateProxy receives a node to dispatch the event
    function dispatchPointerEnter(currentTarget, relatedTarget, generateProxy) {
        var commonParent = getFirstCommonNode(currentTarget, relatedTarget);
        var node = currentTarget;
        var nodelist = [];
        while (node && node !== commonParent) {//target range: this to the direct child of parent relatedTarget
            if (checkEventRegistration(node, "pointerenter")) //check if any parent node has pointerenter
                nodelist.push(node);
            node = node.parentNode;
        }
        while (nodelist.length > 0)
            generateProxy(nodelist.pop());
    }

    //generateProxy receives a node to dispatch the event
    function dispatchPointerLeave(currentTarget, relatedTarget, generateProxy) {
        var commonParent = getFirstCommonNode(currentTarget, relatedTarget);
        var node = currentTarget;
        while (node && node !== commonParent) {//target range: this to the direct child of parent relatedTarget
            if (checkEventRegistration(node, "pointerleave"))//check if any parent node has pointerleave
                generateProxy(node);
            node = node.parentNode;
        }
    }

    // Handling events on window to prevent unwanted super-bubbling
    // All mouse events are affected by touch fallback
    function applySimpleEventTunnels(nameGenerator, eventGenerator) {
        ["pointerdown", "pointermove", "pointerup", "pointerover", "pointerout"].forEach(function (eventName) {
            window.addEventListener(nameGenerator(eventName), function (evt) {
                if (!touching && findEventRegisteredNode(evt.target, eventName))
                    eventGenerator(evt, eventName, { bubbles: true });
            });
        });
        if (window['on' + nameGenerator("pointerenter").toLowerCase()] === undefined)
            window.addEventListener(nameGenerator("pointerover"), function (evt) {
                if (touching)
                    return;
                var foundNode = findEventRegisteredNode(evt.target, "pointerenter");
                if (!foundNode || foundNode === window)
                    return;
                else if (!foundNode.contains(evt.relatedTarget)) {
                    dispatchPointerEnter(foundNode, evt.relatedTarget, function (targetNode) {
                        eventGenerator(evt, "pointerenter", { target: targetNode });
                    });
                }
            });
        if (window['on' + nameGenerator("pointerleave").toLowerCase()] === undefined)
            window.addEventListener(nameGenerator("pointerout"), function (evt) {
                if (touching)
                    return;
                var foundNode = findEventRegisteredNode(evt.target, "pointerleave");
                if (!foundNode || foundNode === window)
                    return;
                else if (!foundNode.contains(evt.relatedTarget)) {
                    dispatchPointerLeave(foundNode, evt.relatedTarget, function (targetNode) {
                        eventGenerator(evt, "pointerleave", { target: targetNode });
                    });
                }
            });
    }

    (function () {
        if (window.MSPointerEvent) {
            //IE 10
            applySimpleEventTunnels(
                function (name) { return getPrefixEventName("MS", name); },
                generateTouchClonedEvent);
        }
        else {
            applySimpleEventTunnels(getMouseEquivalentEventName, generateMouseProxy);

            // Handling move on window to detect pointerleave/out/over
            if (window.ontouchstart !== undefined) {
                window.addEventListener('touchstart', function (eventObject) {
                    for (var i = 0; i < eventObject.changedTouches.length; ++i) {
                        var touchPoint = eventObject.changedTouches[i];
                        previousTargets[touchPoint.identifier] = touchPoint.target;
                        defaultPreventions[touchPoint.identifier] = checkPreventDefault(touchPoint.target);

                        generateTouchEventProxyIfRegistered("pointerover", touchPoint, touchPoint.target, eventObject, { bubbles: true, buttons: 1 });

                        //pointerenter should not be bubbled
                        dispatchPointerEnter(touchPoint.target, null, function (targetNode) {
                            generateTouchEventProxy("pointerenter", touchPoint, targetNode, eventObject, { buttons: 1 });
                        });

                        generateTouchEventProxyIfRegistered("pointerdown", touchPoint, touchPoint.target, eventObject, { bubbles: true, buttons: 1 });
                    }
                    setTouchTimer();
                });

                window.addEventListener('touchend', function (eventObject) {
                    for (var i = 0; i < eventObject.changedTouches.length; ++i) {
                        var touchPoint = eventObject.changedTouches[i];
                        var currentTarget = previousTargets[touchPoint.identifier];

                        if (!currentTarget)
                            continue;

                        generateTouchEventProxyIfRegistered("pointerup", touchPoint, currentTarget, eventObject, { bubbles: true });
                        generateTouchEventProxyIfRegistered("pointerout", touchPoint, currentTarget, eventObject, { bubbles: true });

                        //pointerleave should not be bubbled
                        dispatchPointerLeave(currentTarget, null, function (targetNode) {
                            generateTouchEventProxy("pointerleave", touchPoint, targetNode, eventObject);
                        });
                        delete previousTargets[touchPoint.identifier];
                        delete defaultPreventions[touchPoint.identifier];
                    }
                    setTouchTimer();
                });

                window.addEventListener('touchmove', function (eventObject) {
                    for (var i = 0; i < eventObject.changedTouches.length; ++i) {
                        var touchPoint = eventObject.changedTouches[i];
                        var newTarget = document.elementFromPoint(touchPoint.clientX, touchPoint.clientY);
                        var currentTarget = previousTargets[touchPoint.identifier];

                        if (!currentTarget)
                            continue;

                        var defaultPreventedElement = defaultPreventions[touchPoint.identifier];
                        // If force preventDefault
                        if (defaultPreventedElement) {
                            if (defaultPreventedElement.style.touchAction === undefined)
                                eventObject.preventDefault();
                        }
                            // touchmove without `touch-action: none` fires pointercancel
                        else {
                            delete previousTargets[touchPoint.identifier];
                            generateTouchEventProxyIfRegistered("pointercancel", touchPoint, currentTarget, eventObject, { bubbles: true, buttons: 1 });
                            generateTouchEventProxyIfRegistered("pointerout", touchPoint, currentTarget, eventObject, { bubbles: true, buttons: 1 });

                            dispatchPointerLeave(currentTarget, null, function (targetNode) {
                                generateTouchEventProxy("pointerleave", touchPoint, targetNode, eventObject, { buttons: 1 });
                            });
                            continue;
                        }

                        generateTouchEventProxyIfRegistered("pointermove", touchPoint, currentTarget, eventObject, { bubbles: true, buttons: 1 });
                        if (!navigator.isCocoonJS) {
                            var newTarget = document.elementFromPoint(touchPoint.clientX, touchPoint.clientY);
                            if (currentTarget === newTarget) {
                                continue; // We can skip this as the pointer is effectively over the current target
                            }

                            if (currentTarget) {
                                // Raise out
                                generateTouchEventProxyIfRegistered("pointerout", touchPoint, currentTarget, eventObject, { bubbles: true, buttons: 1, relatedTarget: newTarget });

                                // Raise leave
                                if (!currentTarget.contains(newTarget)) { // Leave must be called if the new target is not a child of the current
                                    dispatchPointerLeave(currentTarget, newTarget, function (targetNode) {
                                        generateTouchEventProxy("pointerleave", touchPoint, targetNode, eventObject, { buttons: 1, relatedTarget: newTarget });
                                    });
                                }
                            }

                            if (newTarget) {
                                // Raise over
                                generateTouchEventProxyIfRegistered("pointerover", touchPoint, newTarget, eventObject, { bubbles: true, buttons: 1, relatedTarget: currentTarget });

                                // Raise enter
                                if (!newTarget.contains(currentTarget)) { // Leave must be called if the new target is not the parent of the current
                                    dispatchPointerEnter(newTarget, currentTarget, function (targetNode) {
                                        generateTouchEventProxy("pointerenter", touchPoint, targetNode, eventObject, { buttons: 1, relatedTarget: currentTarget });
                                    })
                                }
                            }
                            previousTargets[touchPoint.identifier] = newTarget;
                        }
                    }
                    setTouchTimer();
                });

                window.addEventListener('touchcancel', function (eventObject) {
                    for (var i = 0; i < eventObject.changedTouches.length; ++i) {
                        var touchPoint = eventObject.changedTouches[i];

                        generateTouchEventProxyIfRegistered("pointercancel", touchPoint, previousTargets[touchPoint.identifier], eventObject, { buttons: 1 });
                    }
                });
            }
        }
    })();


    // Extension to navigator
    if (navigator.pointerEnabled === undefined) {

        // Indicates if the browser will fire pointer events for pointing input
        navigator.pointerEnabled = true;

        // IE
        if (navigator.msPointerEnabled) {
            navigator.maxTouchPoints = navigator.msMaxTouchPoints;
        }
    }
})();