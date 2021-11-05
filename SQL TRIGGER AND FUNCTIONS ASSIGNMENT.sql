USE synthea;
CREATE table ElizabethS_Discharge( 
id INT AUTO_INCREMENT PRIMARY KEY, 
patient_UID INT NOT NULL, 
last_name VARCHAR(50) NOT NULL,
age INT NOT NULL, 
start_date TEXT(10) NOT NULL, 
end_date TEXT(10) NOT NULL);


INSERT INTO ElizabethS_Discharge(patient_UID, last_name, age, start_date, end_date) 
VALUES (343435, 'Shi', 24, '10-22-2021', '10-25-2021'), 
(343436, 'Red', 51, '10-24-2021', '10-31-2021'),
(343437, 'Orange', 88, '10-15-2021', '10-31-2021'),
(343438, 'Yellow', 37, '10-27-2021', '11-2-2021');


delimiter $$
CREATE TRIGGER AgeError BEFORE INSERT ON ElizabethS_Discharge
FOR EACH ROW
BEGIN
IF NEW.age >=200 then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: NUMBER IS TOO LARGE';
END IF;
END; $$
delimiter ;

delimiter $$
CREATE FUNCTION AgeRanges (ranges INT)
RETURNS VARCHAR(20)
BEGIN
DECLARE Generation VARCHAR(20);
IF ranges <= 24 THEN 
SET Generation = "Gen Z";
ELSEIF ranges <= 40 THEN
SET Generation = "Millennials";
ELSEIF ranges <= 56 THEN
SET Generation = "Boomers II";
ELSEIF ranges <= 66 THEN
SET Generation = "Boomers I";
ELSEIF ranges <= 93 THEN
SET Generation = "Post War";
ELSEIF ranges <= 120 THEN
SET Generation = "WW II";
END IF;
RETURN (Generation);
END
$$
Delimiter ;

SELECT patient_UID, age, AgeRanges(age)
FROM ElizabethS_Discharge;