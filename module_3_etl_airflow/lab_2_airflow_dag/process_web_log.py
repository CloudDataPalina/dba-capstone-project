from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
    'email': ['airflow@example.com'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='process_web_log',
    default_args=default_args,
    description='Process web server logs and archive results',
    schedule_interval='@daily',
    catchup=False
) as dag:

    extract_data = BashOperator(
        task_id='extract_data',
        bash_command=(
            'cut -d " " -f 1 '
            '/home/project/airflow/dags/capstone/accesslog.txt '
            '> /home/project/airflow/dags/capstone/extracted_data.txt'
        )
    )

    transform_data = BashOperator(
        task_id='transform_data',
        bash_command=(
            'grep -v "198.46.149.143" '
            '/home/project/airflow/dags/capstone/extracted_data.txt '
            '> /home/project/airflow/dags/capstone/transformed_data.txt'
        )
    )

    load_data = BashOperator(
        task_id='load_data',
        bash_command=(
            'tar -cvf '
            '/home/project/airflow/dags/capstone/weblog.tar '
            '/home/project/airflow/dags/capstone/transformed_data.txt'
        )
    )

    extract_data >> transform_data >> load_data
