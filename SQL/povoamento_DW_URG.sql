DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereCausa`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE causa VARCHAR(75);
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT DES_CAUSA from bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO causa;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_causa (causa) VALUES (causa);
        
        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereData`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE dataV DATETIME;
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT DATAHORA_ADM FROM bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO dataV;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_data (data_adm) VALUES (dataV);

        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereEspecialidade`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE especialidade VARCHAR(75);
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT ALTA_DES_ESPECIALIDADE FROM bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO especialidade;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_especialidade (especialidade) VALUES (especialidade);
        
        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereGenero`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE genero VARCHAR(3);
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT SEXO FROM bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO genero;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_genero (genero) VALUES (genero);
        
        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereLocal`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE localV VARCHAR(75);
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT DES_LOCAL FROM bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO localV;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_local (localidade) VALUES (localV);
        
        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereProveniencia`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE prov VARCHAR(75);
    -- Cursor
    DECLARE curs CURSOR FOR SELECT DISTINCT DES_PROVENIENCIA FROM bd_urg.urg_inform_geral;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    -- Loop
    get_loop: LOOP
		FETCH curs INTO prov;
        
        IF feito THEN
			LEAVE get_loop;
		END IF;
        
        -- Preenche a tabela em questao
        INSERT INTO DW_URG.dim_proveniencia (proveniencia) VALUES (prov);
        
        
	END LOOP;
    
    CLOSE curs;    
END //

DELIMITER ;

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insereFactsUrg`()
BEGIN
	-- Variaveis
    DECLARE feito BOOLEAN DEFAULT FALSE;
    DECLARE id INT;
    DECLARE id_CAUSA INT;
    DECLARE id_PROVENIENCIA INT;
    DECLARE id_DATA INT;
    DECLARE id_ESPECIALIDADE INT;
    DECLARE id_GENERO INT;
    DECLARE id_LOCAL INT;
    DECLARE idade INT;
    DECLARE tempoUrg INT;
    
    -- Cursors
    DECLARE curs CURSOR FOR
		SELECT UGERAL.URG_EPISODIO, TIMESTAMPDIFF(YEAR, UGERAL.DTA_NASCIMENTO, UGERAL.DATAHORA_ALTA), TIMESTAMPDIFF(MINUTE, UGERAL.DATAHORA_ADM, 
    	UGERAL.DATAHORA_ALTA), DC.id_Causa, DD.id_Data, DE.id_Especialidade, DG.id_Genero, DL.id_Local, DP.id_Proveniencia
		FROM dw_urg.dim_causa AS DC, dw_urg.dim_data AS DD, dw_urg.dim_especialidade AS DE,
		dw_urg.dim_genero AS DG, dw_urg.dim_local AS DL, DW_URG.dim_proveniencia AS DP, bd_urg.urg_inform_geral AS UGERAL 
		WHERE DC.causa = UGERAL.DES_CAUSA AND DD.data_adm = UGERAL.DATAHORA_ADM AND DE.especialidade = UGERAL.ALTA_DES_ESPECIALIDADE AND
			  DG.genero = UGERAL.SEXO AND DL.localidade = UGERAL.DES_LOCAL AND DP.proveniencia = UGERAL.DES_PROVENIENCIA ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
    
    OPEN curs;
    
    get_loop: LOOP
		FETCH curs INTO id, idade, tempoUrg, id_CAUSA, id_DATA, id_ESPECIALIDADE, id_GENERO, id_LOCAL, id_PROVENIENCIA;
    
		IF feito THEN
			LEAVE get_loop;
		END IF;
        
        INSERT INTO dw_urg.facts_urg(id_Facts, idade, tempo_urg, id_Especialidade, id_Local, id_Causa, id_Genero, id_Proveniencia, id_Data)
									VALUES(id, idade, tempoUrg, id_ESPECIALIDADE, id_LOCAL, id_CAUSA, id_GENERO, id_PROVENIENCIA, id_DATA);
		
    END LOOP;
    
    CLOSE curs;
END //
 
DELIMITER ;

call insereCausa();
call insereData();
call insereEspecialidade();
call insereGenero();
call insereLocal();
call insereProveniencia();
call insereFactsUrg();