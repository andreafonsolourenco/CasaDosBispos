IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_IMAGEM_TIPO]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_IMAGEM_TIPO]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_IMAGEM_TIPO](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'IMAGEM TIPO';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @tipo varchar(500);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar tipos de imagem!';
		return
	end

	select @tipo = nome from REPORT_IMAGEM_TIPO(@id, null)

	update images_type set id_imagem_capa = null where images_typeid = @id
	update textos set id_imagem = null where id_imagem in (select imageid from IMAGE where ID_TIPO = @id)
	delete from [IMAGE] where id_tipo = @id
	delete from IMAGES_TYPE where IMAGES_TYPEID = @id

	set @ret = @id;
	set @retMsg = 'Tipo de Imagem eliminado com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu o tipo de imagem ', @tipo, ' e todas as imagens associadas!')

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END;
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_IMAGEM]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_IMAGEM]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_IMAGEM](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @nome varchar(500);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar imagens!';
		return
	end

	select @nome = nome from REPORT_IMAGEM(@id, null, null)

	update images_type set id_imagem_capa = null where id_imagem_capa = @id
	update textos set id_imagem = null where id_imagem = @id
	delete from [IMAGE] where IMAGEID = @id

	set @ret = @id;
	set @retMsg = 'Imagem eliminada com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu a imagem ', @nome, '!')

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END
GO


IF COL_LENGTH('IMAGE','horizontal') IS NULL
BEGIN
	ALTER TABLE [IMAGE]
	ADD horizontal bit not null default 0
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_IMAGEM]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_IMAGEM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_IMAGEM](@id int, @nome varchar(500), @id_tipo int)
returns table as return
(
	select
		img.IMAGEID as id,
		img.nome_en,
		img.nome_es,
		img.nome_fr,
		img.nome,
		img.ordem,
		img.slider_inicial,
		img.extensao,
		img.visivel,
		img.horizontal,
		img_tp.id as id_tipo,
		img_tp.nome as nome_tipo,
		img_tp.nome_en as nome_en_tipo,
		img_tp.nome_fr as nome_fr_tipo,
		img_tp.nome_es as nome_es_tipo,
		img_tp.ordem as ordem_tipo,
		img_tp.id_imagem_capa as id_imagem_capa_tipo,
		img_tp.img_capa as img_capa_tipo,
		img_tp.visivel as visivel_tipo
	from [IMAGE] img
	inner join [REPORT_IMAGEM_TIPO](@id_tipo, null) img_tp on img_tp.id = img.id_tipo
	where (@id_tipo is null or @id_tipo = img_tp.id)
	and (@id is null or @id = img.IMAGEID)
	and (@nome is null or @nome = img.nome)
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SITE_REPORT_IMAGEM]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [SITE_REPORT_IMAGEM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SITE_REPORT_IMAGEM](@id int, @id_tipo int, @lingua varchar(10))
returns table as return
(
	select
		img.IMAGEID as id,
		case when @lingua = 'EN' then img.nome_en else
		case when @lingua = 'ES' then img.nome_es else
		case when @lingua = 'FR' then img.nome_fr else
		img.nome end end end as nome,
		img.ordem,
		img.slider_inicial,
		img.extensao,
		img.visivel,
		img.horizontal,
		img_tp.id as id_tipo,
		img_tp.nome as nome_tipo,
		img_tp.ordem as ordem_tipo,
		img_tp.id_imagem_capa as id_imagem_capa_tipo,
		img_tp.img_capa as img_capa_tipo,
		img_tp.visivel as visivel_tipo
	from [IMAGE] img
	inner join [SITE_REPORT_IMAGEM_TIPO](@id_tipo, @lingua) img_tp on img_tp.id = img.id_tipo
	where (@id_tipo is null or @id_tipo = img_tp.id)
	and (@id is null or @id = img.IMAGEID)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_IMAGEM]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_IMAGEM]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_IMAGEM](
	@idUser int,
	@id INT,
	@nome varchar(500),
	@nome_en varchar(500),
	@nome_fr varchar(500),
	@nome_es varchar(500),
	@ordem int,
	@slider_inicial bit,
	@nome_tipo varchar(500),
	@nome_en_tipo varchar(500),
	@nome_fr_tipo varchar(500),
	@nome_es_tipo varchar(500),
	@ordem_tipo int,
	@extensao varchar(10),
	@visivel bit,
	@visivel_tipo bit,
	@horizontal bit,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @id_tipo int = (select id from REPORT_IMAGEM_TIPO(null, @nome_tipo))
	DECLARE @id_img_capa int = (select id_imagem_capa from REPORT_IMAGEM_TIPO(null, @nome_tipo))

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		if(isnull(@id_tipo, 0) = 0)
		begin
			set @id_tipo = 0;
			EXEC CRIA_EDITA_IMAGEM_TIPO @idUser, @id_tipo, @nome_tipo, @nome_en_tipo, @nome_fr_tipo, @nome_es_tipo, @ordem_tipo, null, @visivel_tipo, @ret OUTPUT, @retMsg OUTPUT;
		end
		else
		begin
			EXEC CRIA_EDITA_IMAGEM_TIPO @idUser, @id_tipo, @nome_tipo, @nome_en_tipo, @nome_fr_tipo, @nome_es_tipo, @ordem_tipo, @id_img_capa, @visivel_tipo, @ret OUTPUT, @retMsg OUTPUT;
		end		

		if(@ret <= 0)
		begin
			return
		end
		else
		begin
			set @id_tipo = @ret;
			select top 1 @id = id from [REPORT_IMAGEM](@id, @nome, null)

			if(@horizontal = null)
			begin
				set @horizontal = (select horizontal from REPORT_IMAGEM(@id, @nome, @id_tipo));
			end
			else
			begin
				set @horizontal = @horizontal;
			end

			if(isnull(@id, 0) <= 0)
			begin
				insert into [IMAGE](nome, nome_en, nome_fr, nome_es, ordem, slider_inicial, id_tipo, EXTENSAO, visivel, horizontal, ctrldataupdt, ctrlcodopupdt)
				values(@nome, @nome_en, @nome_fr, @nome_es, @ordem, @slider_inicial, @id_tipo, @extensao, @visivel, @horizontal, getdate(), @codOp)

				set @ret = SCOPE_IDENTITY();
				set @id = @ret;
				set @retMsg = CONCAT('Imagem ', @nome, ' inserida com sucesso!');

				set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados da imagem ', @nome)
				EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			end
			else
			begin
				if(isnull(@extensao, '') = '')
				begin
					select @extensao = EXTENSAO from [image] where imageid = @id
				end
				else
				begin
					set @extensao = @extensao
				end

				update [IMAGE]
					set nome = @nome,
					nome_en = @nome_en,
					nome_fr = @nome_fr,
					nome_es = @nome_es,
					ordem = @ordem,
					slider_inicial = @slider_inicial,
					id_tipo = @id_tipo,
					EXTENSAO = @extensao,
					visivel = @visivel,
					horizontal = @horizontal,
					ctrldataupdt = getdate(),
					ctrlcodopupdt = @codOp
				where IMAGEID = @id

				set @ret = @id;
				set @retMsg = CONCAT('Imagem ', @nome, ' atualizada com sucesso!');

				set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados da imagem ', @nome)
				EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			end

			return;
		end
	end

	set @ret = -2;
	set @retMsg = 'Imagem não encontrada!';
	return
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UPDATE_SLIDER_INICIAL]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[UPDATE_SLIDER_INICIAL]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UPDATE_SLIDER_INICIAL](
	@idUser int,
	@id INT,
	@slider_inicial bit,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @nome varchar(500);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		select top 1 @nome = nome from REPORT_IMAGEM(@id, null, null)

		if(isnull(@nome, '') = '')
		begin
			set @ret = -2;
			set @retMsg = 'Imagem não encontrada!';
			return
		end
		else
		begin
			update [IMAGE]
				set slider_inicial = @slider_inicial,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where IMAGEID = @id

			set @ret = @id;

			if(@slider_inicial = 1)
			begin
				set @retMsg = CONCAT('Imagem ', @nome, ' colocada no slider inicial!');
				set @log = CONCAT('O utilizador ', @codOp, ' colocou a imagem ', @nome, ' no slider inicial!')
			end
			else
			begin
				set @retMsg = CONCAT('Imagem ', @nome, ' retirada do slider inicial!');
				set @log = CONCAT('O utilizador ', @codOp, ' retirou a imagem ', @nome, ' do slider inicial!')
			end
			
			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
	end
END
GO