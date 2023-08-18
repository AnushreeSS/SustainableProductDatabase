# Sustainable Product Database (User Guide)
### Using Sustainable Product Database
In order to use the sustainable product database, the user must
1.	Download the [database](sustainable_product_db_final.db.gz) (provided in compressed .gzip format) from the GitHub repository.
2.	Install Sqlite3 and Pandas python modules if not installed already.
3.	Use the UseSustainableProductDB.ipynb notebook to load the view containing sustainable products.
4.	Additionally, data in the database can be queried and retrieved through simple SQL queries.
### Building Data Pipeline From Scratch
The design given in the project report gives a fair understanding of the process of creating a data pipeline. [MainProjectPipeline.ipynb](MainProjectPipeline.ipynb) notebook is an actual implementation of one such pipeline from scratch. A summary of the steps to be followed is listed below:
1.	Read the product dataset from any source and explore the fields
2.	Decide on the pre-processing pipeline design for that data – leverage ColumnDropper, RowDropper, StringCleaner classes 
3.	Load the ontology data (already processed data – [vocab_updated.xlsx](resources/vocab_updated.xlsx) available on Git repo).
4.	Implement the keyword extraction step using KeywordExtractor class.
5.	Implement keyword mapper using KeywordMapper class.
6.	Investigate the results and tune the vocabulary as required.
7.	Insert the data generated at different stages into the sustainable product database using the DBWriter class.
8.	Save the keyword extractor and mapper objects using Pickle Python module in order to reuse later.
 
### Building Data Pipeline using Pre-Existing Data
If there is an already existing data pipeline with keyword extractor and mapper classes saved, then, the same objects can be used on a different product database. [SecondDataPipeline.ipynb](SecondDataPipeline.ipynb) is an example of this design. To do this, the steps listed below can be followed.
1.	Read the product dataset from any source and explore the fields
2.	Decide on the pre-processing pipeline design for that data – leverage ColumnDropper, RowDropper, StringCleaner classes 
3.	Load the keyword extractor object and extract keywords from the new product data. 
4.	Load the keyword mapper object, set the results of the previous step in this object and then map the keywords using the ontology data already saved in the object. 
5.	Investigate the results and tune the vocabulary as required.
6.	Insert the data generated at different stages into the sustainable product database using the DBWriter class.
