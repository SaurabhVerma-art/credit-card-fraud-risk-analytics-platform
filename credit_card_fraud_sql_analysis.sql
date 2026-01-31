create database credit_card_db;

select * from cleaned_credit_card_data;

-- 1. What is the total transactions in the bank?

select count(*) as total_transactions
from cleaned_credit_card_data;

#insights: helps bank understand overall transaction volume being monitored.

-- 2. How many transactions were fraudulent?

Select count(*) as fraud_transactions
from cleaned_credit_card_data
where is_fraud = 1;

#insights: Even small fraud count can cause large financial loss. 

-- 3. What is the overall fraud rate?

select
  round(
   sum(is_fraud)*100.0 / count(*), 2
  ) as fraud_rate_percent
from cleaned_credit_card_data; 

#insights: Bank should focus on reducing this percentage over time.

-- 4. What is the total financial loss due to fraud? 

select 
  sum(amount) as total_fraud_loss
from cleaned_credit_card_data
where is_fraud = 1;

#insights: Shows actual monetary impact of fraud on the bank.

-- 5. What is the average loss per fraudulent transaction? 

select  
  avg(amount) as avg_fraud_amount
from cleaned_credit_card_data
where is_fraud = 1; 

#insights: Helps bank design transaction monitoring thresholds.

-- 6. What is the fraud count by transaction type (Online/POS/ATM/UPI)? 

select 
  transaction_type,
  count(*) AS fraud_count
from cleaned_credit_card_data
where is_fraud = 1
group by transaction_type
order by fraud_count desc;

#insights: Bank should tighten security for online transactions. 

-- 7. What is fraud by country?

select 
  country,
  count(*) as fraud_count
from cleaned_credit_card_data
where is_fraud = 1
group by country
order by fraud_count desc;

#insights: Bank can apply stricter checks on international transactions.

-- 8. At what hour does fraud happen most?

select 
  hour,
  COUNT(*) as fraud_count
from cleaned_credit_card_data
where is_fraud = 1
group by hour
order by fraud_count desc;

#insights: Bank can increase real-time monitoring at night.

-- 9. Are high-value transactions more risky?

select
  case 
     when amount > 50000 then 'High Value'
     else 'Normal'
  end as txn_category,
  count(*) as total_txns,
  sum(is_fraud) as fraud_txns,
  round(sum(is_fraud)*100.0/count(*),2) as fraud_rate
from cleaned_credit_card_data
group by 
  case 
     when amount > 50000 then 'High Value'
     else 'Normal'
  end;
  
  #insights: Bank should add extra verification for high-value payments
  
  -- 10. What is the average time to detect fraud? 
  
  SELECT 
  AVG(detection_time_min) AS avg_detection_time
FROM cleaned_credit_card_data
WHERE is_fraud = 1;

#insights: Bank should aim to reduce detection time below 30 minutes.

-- 11. What is fraud loss by transaction type?

SELECT 
  transaction_type,
  SUM(amount) AS fraud_loss
FROM cleaned_credit_card_data
WHERE is_fraud = 1
GROUP BY transaction_type
ORDER BY fraud_loss DESC;

#insights: Helps bank prioritize security investment.

-- 12. What is top 5 merchants with highest fraud cases?

select 
  merchant,
  count(*) as fraud_cases
from cleaned_credit_card_data
where is_fraud = 1
group by merchant
order by fraud_cases desc
limit 5;

#insights: Bank can blacklist or monitor risky merchants closely.
