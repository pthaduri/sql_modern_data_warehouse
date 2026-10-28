/*
To execute stored procedure
EXEC bronze.bronze_load;
*/

CREATE OR ALTER PROCEDURE bronze.bronze_load AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================';

		PRINT '----------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>> Inserting data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\datawarehouse/cust_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>> Inserting data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\datawarehouse/prd_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>> Inserting data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\datawarehouse/sales_details.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		PRINT '----------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>> Inserting data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\datawarehouse/cust_az12.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>> Inserting data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\datawarehouse/loc_a101.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		SET @start_time = GETDATE();
		PRINT '>>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>> Inserting data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\datawarehouse/px_cat_g1v2.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR);
		PRINT '**************************';

		SET @batch_end_time = GETDATE();
		PRINT('>>>Bronze Layer load completed')
		PRINT'Total load Duration: '+ CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS VARCHAR)+ ' seconds';
	END TRY

	BEGIN CATCH
		PRINT'******************************************';
		PRINT'Error Occured during loading Bronze Layer';
		PRINT'Error Message: '+ ERROR_MESSAGE();
		PRINT'Error Number: '+ CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT'Error State: '+ CAST(ERROR_STATE() AS VARCHAR);
		PRINT'******************************************';
	END CATCH
END
