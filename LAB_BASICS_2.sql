use bank;

select * from  client
where district_id = 1
limit 5;

SELECT client_id FROM CLIENT
WHERE district_id = 72
order by client_id desc
LIMIT 1;

SELECT amount from loan
ORDER by amount asc
limit 3;

SELECT DISTINCT STATUS from loan
ORDER BY status desc;

SELECT loan_ID
FROM loan
ORDER BY payments
LIMIT 1;

SELECT account_id, amount
FROM loan
ORDER BY account_id ASC
LIMIT 5;

SELECT account_id
FROM LOAN
WHERE duration = 60
ORDER BY amount ASC
LIMIT 5;

#What are the unique values of k_symbol in the order table?

SELECT DISTINCT(k_symbol)
FROM bank.order;

#In the order table, what are the order_ids of the client with the account_id 34?

SELECT DISTINCT(order_id)
from bank.order
where account_id = 34
order by order_id;

# In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

SELECT DISTINCT account_id
FROM bank.order
WHERE order_id BETWEEN 29540 and 29560;

# In the order table, what are the individual amounts that were sent to (account_to) id 30067122?

SELECT DISTINCT amount
FROM bank.order
WHERE account_to = 30067122;

#In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.

SELECT trans_id, date, type, amount
FROM trans
where account_id = 793
ORDER BY date desc
LIMIT 10;

# In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.

SELECT district_id, count(client_id) 
FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id;

# In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.

SELECT type, count(card_id) 
FROM card
GROUP BY type
Order by count(card_id) desc;

# Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

SELECT account_id, amount
FROM loan
GROUP BY account_id
ORDER by amount desc
limit 10;

# In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

SELECT date, COUNT(loan_id)
FROM loan
WHERE date < 930907
GROUP BY date
ORDER BY date desc;

# In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, 
# both in ascending order. You can ignore days without any loans in your output.

SELECT date, duration, COUNT(loan_id)
FROM loan
WHERE date BETWEEN 971201 AND 971231
GROUP BY date, duration
ORDER BY date, duration;

# Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type

SELECT account_id, type, sum(amount)
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY account_id, type;

# From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

SELECT account_id, type, sum(amount),
CASE
	WHEN type = "PRIJEM" THEN "INCOMING"
    WHEN type = "VYDAJ" THEN "OUTGOING"
END as ENG_TRANS
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY account_id, type;

# From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.

SELECT account_id,
sum(case 
when trans.type = "PRIJEM" then amount
else 0
end) as "incoming",
sum(case 
when trans.type = "VYDAJ" then amount
else 0
end) as "Outgoing",
sum(case 
when trans.type = "PRIJEM" then amount
when trans.type = "VYDAJ" then -amount
else 0
end) as "total_amount"
from trans
where account_id= 396;

#Continuing with the previous example, rank the top 10 account_ids based on their difference.

SELECT account_id,
ROUND(SUM(CASE
	WHEN trans.type = "PRIJEM" THEN amount
	WHEN trans.type = "VYDAJ" THEN -amount
    else 0
END)) as TOTAL_AMOUNT
FROM TRANS
GROUP BY account_id
ORDER BY total_amount desc
LIMIT 10;




