CREATE DATABASE IF NOT EXISTS github_${environment}_data;
CREATE EXTERNAL TABLE IF NOT EXISTS github_${environment}_data.workflow_run (
	project STRING,
	branch STRING,
	event_type STRING,
	action STRING,
	workflow_run STRUCT< 
    	id: BIGINT,
    	name: STRING,
    	node_id: STRING,
    	head_branch: STRING,
    	head_sha: STRING,
    	path: STRING,
    	display_title: STRING,
    	run_number: INT,
    	event: STRING,
    	status: STRING,
    	conclusion: STRING,
    	workflow_id: BIGINT,
    	check_suite_id: BIGINT,
    	check_suite_node_id: STRING,
    	url: STRING,
    	html_url: STRING,
    	created_at: STRING,
    	updated_at: STRING,
    	actor: STRUCT < 
        	login: STRING,
        	id: BIGINT,
        	node_id: STRING,
        	avatar_url: STRING,
        	html_url: STRING
        >,
    	run_started_at: STRING
	>,
	repository STRUCT < 
    	id: BIGINT,
    	name: STRING,
    	full_name: STRING,
    	private: BOOLEAN,
    	html_url: STRING 
	>
) ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://${s3_bucket}/raw/event_type=workflow_run/';
CREATE EXTERNAL TABLE IF NOT EXISTS github_${environment}_data.workflow_job(
	project STRING,
	branch STRING,
	event_type STRING,
	action STRING,
	workflow_job STRUCT < id: BIGINT,
	run_id: BIGINT,
	workflow_name: STRING,
	head_branch: STRING,
	run_url: STRING,
	status: STRING,
	conclusion: STRING,
	created_at: STRING,
	started_at: STRING,
	completed_at: STRING,
	name: STRING,
	labels: ARRAY < STRING > >,
	deployment STRUCT < id: BIGINT,
	task: STRING,
	original_environment: STRING,
	environment: STRING,
	created_at: STRING,
	updated_at: STRING >,
	repository STRUCT < id: BIGINT,
	name: STRING,
	full_name: STRING,
	private: BOOLEAN,
	default_branch: STRING >,
	organization STRUCT < login: STRING,
	id: BIGINT >,
	sender STRUCT < login: STRING,
	id: BIGINT >
) ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://${s3_bucket}/raw/event_type=workflow_job/';
CREATE EXTERNAL TABLE IF NOT EXISTS github_${environment}_data.deployment(
	project STRING,
	branch STRING,
	event_type STRING,
	action STRING,
	workflow_run STRUCT< 
    	id: BIGINT,
    	name: STRING,
    	node_id: STRING,
    	head_branch: STRING,
    	head_sha: STRING,
    	path: STRING,
    	display_title: STRING,
    	run_number: INT,
    	event: STRING,
    	status: STRING,
    	conclusion: STRING,
    	workflow_id: BIGINT,
    	check_suite_id: BIGINT,
    	check_suite_node_id: STRING,
    	url: STRING,
    	html_url: STRING,
    	created_at: STRING,
    	updated_at: STRING,
    	actor: STRUCT < 
        	login: STRING,
        	id: BIGINT,
        	node_id: STRING,
        	avatar_url: STRING,
        	html_url: STRING
        >,
    	run_started_at: STRING
	>,
	deployment STRUCT < 
    	id: BIGINT,
    	task: STRING,
    	original_environment: STRING,
    	environment: STRING,
    	created_at: STRING,
    	updated_at: STRING 
    >,
	repository STRUCT < 
    	id: BIGINT,
    	name: STRING,
    	full_name: STRING,
    	private: BOOLEAN,
    	default_branch: STRING 
    >,
	organization STRUCT < 
    	login: STRING,
    	id: BIGINT 
    >,
	sender STRUCT < 
	    login: STRING,
	    id: BIGINT 
    >
) ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://${s3_bucket}/raw/event_type=deployment/';
CREATE EXTERNAL TABLE IF NOT EXISTS github_${environment}_data.deployment_status(
	project STRING,
	branch STRING,
	event_type STRING,
	action STRING,
	workflow_run STRUCT< 
    	id: BIGINT,
    	name: STRING,
    	node_id: STRING,
    	head_branch: STRING,
    	head_sha: STRING,
    	path: STRING,
    	display_title: STRING,
    	run_number: INT,
    	event: STRING,
    	status: STRING,
    	conclusion: STRING,
    	workflow_id: BIGINT,
    	check_suite_id: BIGINT,
    	check_suite_node_id: STRING,
    	url: STRING,
    	html_url: STRING,
    	created_at: STRING,
    	updated_at: STRING,
    	actor: STRUCT < 
        	login: STRING,
        	id: BIGINT,
        	node_id: STRING,
        	avatar_url: STRING,
        	html_url: STRING
        >,
    	run_started_at: STRING
	>,
	deployment STRUCT < 
    	id: BIGINT,
    	task: STRING,
    	original_environment: STRING,
    	environment: STRING,
    	created_at: STRING,
    	updated_at: STRING 
    >,
    deployment_status STRUCT < 
    	id: BIGINT,
    	state: STRING,
    	environment: STRING,
    	created_at: STRING,
    	updated_at: STRING
    >,
	repository STRUCT < 
    	id: BIGINT,
    	name: STRING,
    	full_name: STRING,
    	private: BOOLEAN,
    	default_branch: STRING 
    >,
	organization STRUCT < 
    	login: STRING,
    	id: BIGINT 
    >,
	sender STRUCT < 
	    login: STRING,
	    id: BIGINT 
    >
) ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://${s3_bucket}/raw/event_type=deployment_status/';
CREATE EXTERNAL TABLE IF NOT EXISTS github_dev_data.push (
	project STRING,
	branch STRING,
	event_type STRING,
	before STRING,
	after STRING, 
	action STRING,
	repository STRUCT < 
    	id: BIGINT,
    	name: STRING,
    	full_name: STRING,
    	private: BOOLEAN 
	>
) ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://tsk-dev-github-events/raw/event_type=push/';