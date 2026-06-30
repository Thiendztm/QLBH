SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT @@session.tx_isolation;

call update_ton_kho(1, 7);

call them_ton_kho(2, 20);

call update_sp_gia(6, -20000);

