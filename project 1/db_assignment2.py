from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

db = create_engine("mysql+mysqlconnector://root:radmin1!@localhost:3306/db_assgnmt2")

Session = sessionmaker(bind=db)
cursor = Session()

#3.1 Update phone number of Askar Askarov
print("3.1 Update phone number of Askar Askarov to +77771010001")
alter_phone_query = text("UPDATE user SET phone_number = '+77771010001' WHERE given_name = 'Askar' AND surname = 'Askarov'")
cursor.execute(alter_phone_query)

#3.2 Update hourly rate
print("3.2 Add $0.5 commission fee to the Caregivers’ hourly rate if it's less than $9, or 10percent if it's not")
alter_hourly_rate_query = text("UPDATE caregiver SET hourly_rate = CASE WHEN hourly_rate < 9 THEN hourly_rate + 0.5 ELSE hourly_rate + hourly_rate * 0.1 END")
cursor.execute(alter_hourly_rate_query)

#4.1 Delete the jobs posted by Bolat Bolatov
print("4.1 Delete the jobs posted by Bolat Bolatov") 
drop_jobs_query = text("DELETE FROM JOB WHERE member_user_id IN (SELECT user_id FROM USER WHERE given_name = 'Bolat' AND surname = 'Bolatov')")
cursor.execute(drop_jobs_query)

# 4.2 Delete all users who live on Turan street, only members have an address
print("4.2 Delete all members who live on Turan street")
drop_members_query = text(""" DELETE FROM USER  WHERE user_id IN ( SELECT USER.user_id FROM (SELECT * FROM USER) As user JOIN MEMBER ON MEMBER.member_user_id = user.user_id JOIN ADDRESS ON MEMBER.member_user_id = ADDRESS.member_user_id WHERE ADDRESS.street = 'Turan') """)
cursor.execute(drop_members_query)

#5.1 Select caregiver and member names for the accepted appointments.
print("5.1 Select caregiver and member names for the accepted appointments")
select_confrimed_appointments_query = text(""" SELECT apt.appointment_id, uscar.given_name AS caregiver_given_name, uscar.surname AS caregiver_surname, usmem.given_name AS member_given_name, usmem.surname AS member_surname FROM appointment apt JOIN caregiver crg ON apt.caregiver_user_id = crg.caregiver_user_id JOIN member mem ON apt.member_user_id = mem.member_user_id JOIN user uscar ON crg.caregiver_user_id = uscar.user_id JOIN user usmem ON mem.member_user_id = usmem.user_id WHERE apt.status = 'confirmed'; """)

result = cursor.execute(select_confrimed_appointments_query)
for row in result.fetchall():
    column_names = result.keys()
    row_dict = dict(zip(column_names, row))
    
    print(f"Confirmed Appointment ID: {row_dict['appointment_id']}")
    print(f"Caregiver's Name: {row_dict['caregiver_given_name']} {row_dict['caregiver_surname']}")
    print(f"Member's Name: {row_dict['member_given_name']} {row_dict['member_surname']}")
    print("-" * 30)

# #5.2 List job ids that contain ‘gentle’ in their other requirements.
print("5.2 List job ids that contain ‘gentle’ in their other requirements")
select_key_gentle_query = text(""" SELECT job_id FROM JOB WHERE LOWER(other_requirements) LIKE '%gentle%' """)
result = cursor.execute(select_key_gentle_query)
for row in result:
    print(row)

#5.3 List the work hours of Baby Sitter positions.
print("5.3 List the work hours of Baby Sitter positions")
select_babysitter_work_hours_query = text(""" SELECT JOB.job_id, APPOINTMENT.work_hours FROM JOB JOIN MEMBER ON JOB.member_user_id = MEMBER.member_user_id JOIN APPOINTMENT ON APPOINTMENT.member_user_id = MEMBER.member_user_id  WHERE JOB.required_caregiving_type = 'Baby Sitter'  """)

result = cursor.execute(select_babysitter_work_hours_query)

# Fetch and print the results
for row in result:
    print("Job ID:", row[0])
    print("Work Hours:", row[1])
    print("\n")    

#5.4 List the members who are looking for Elderly Care in Astana and have “No pets.” rule.
print("5.4 List the members who are looking for Elderly Care in Astana and have “No pets.” rule")
select_elderly_care_members_query = text(""" SELECT USER.given_name, USER.surname, USER.city, MEMBER.house_rules FROM USER JOIN MEMBER ON MEMBER.member_user_id = USER.user_id JOIN JOB on JOB.member_user_id = MEMBER.member_user_id WHERE JOB.required_caregiving_type = 'Elderly Care' AND USER.city = 'Astana' AND MEMBER.house_rules = 'No pets.' """)
result = cursor.execute(select_elderly_care_members_query)
for row in result:
    print("First name: ", row[0])
    print("Last name: ", row[1])
    print("City: ", row[2])
    print("House rules: ", row[3])
    print("\n")

#6.1 Count the number of applicants for each job posted by a member (multiple joins with aggregation)
print("6.1 Count the number of applicants for each job posted by a member (multiple joins with aggregation)")
applicants_number_query = text(""" SELECT JOB.job_id, COUNT(JOB_APPLICATION.caregiver_user_id) AS applicant_count FROM JOB LEFT JOIN JOB_APPLICATION ON JOB_APPLICATION.job_id = JOB.job_id GROUP BY JOB.job_id """)
result = cursor.execute(applicants_number_query)
for row in result:
    print(f"job ID: {row[0]}  number of applicants: {row[1]}")
    print("\n")
    
#6.2 Total hours spent by care givers for all accepted appointments (multiple joins with aggregation)
print("6.2 Total hours spent by care givers for all accepted appointments (multiple joins with aggregation)")   
confirmed_appointments_total_hours_query = text(""" SELECT APPOINTMENT.caregiver_user_id, SUM(APPOINTMENT.work_hours) AS total_hours FROM APPOINTMENT WHERE APPOINTMENT.status = 'Confirmed' GROUP BY APPOINTMENT.caregiver_user_id """)
result = cursor.execute(confirmed_appointments_total_hours_query)
for row in result:
    print(f"Caregiver ID: {row[0]}, Total hours spent: {row[1]}") 
    print("\n")

#6.3 Average pay of caregivers based on accepted appointments (join with aggregation)
print("6.3 Average pay of caregivers based on accepted appointments (join with aggregation)")
caregivers_average_pay_query = text(""" SELECT AVG(CAREGIVER.hourly_rate) AS average_pay FROM APPOINTMENT JOIN CAREGIVER ON CAREGIVER.caregiver_user_id = APPOINTMENT.caregiver_user_id WHERE APPOINTMENT.status = 'Confirmed' """)
result = cursor.execute(caregivers_average_pay_query)
for row in result:
    print(f"Average pay: {row[0]}")    
       
       
#6.4 Caregivers who earn above average based on accepted appointments (multiple join withaggregation and nested query)
print("6.4 Caregivers who earn above average based on accepted appointments (multiple join with aggregation and nested query)")
confirmed_above_average_earnings_query = text(""" SELECT USER.given_name, USER.surname, CAREGIVER.hourly_rate FROM USER JOIN CAREGIVER ON CAREGIVER.caregiver_user_id = USER.user_id JOIN APPointment ON Appointment.caregiver_user_id = Caregiver.caregiver_user_id WHERE CAREGIVER.hourly_rate > ( SELECT AVG(CAREGIVER.hourly_rate) FROM APPOINTMENT JOIN CAREGIVER ON CAREGIVER.caregiver_user_id = APPOINTMENT.caregiver_user_id WHERE APPOINTMENT.status = 'Confirmed' ) AND APPOINTMENT.status = 'Confirmed' """)

result = cursor.execute(confirmed_above_average_earnings_query)
for row in result:
    print(f"Full name: {row[0]} {row[1]}   Pay amount: {row[2]}")
    print("\n")

#7.0 Calculate the total cost to pay for a caregiver for all accepted appointments.
print("7.0 Calculate the total cost to pay for a caregiver for all accepted appointments")
confirmed_caregivers_total_cost_query = text(""" SELECT APPOINTMENT.caregiver_user_id, SUM(APPOINTMENT.work_hours * CAREGIVER.hourly_rate) AS total_cost FROM APPOINTMENT JOIN CAREGIVER ON CAREGIVER.caregiver_user_id = APPOINTMENT.caregiver_user_id WHERE APPOINTMENT.status = 'Confirmed' GROUP BY APPOINTMENT.caregiver_user_id """)
result = cursor.execute(confirmed_caregivers_total_cost_query)
for row in result:
    print(f"Caregiver ID:{row[0]}   Total cost: {row[1]}")
    print("\n")
    
#8.0 View all job applications and the applicants
print("8.0 View all job applications and the applicants")
view_all_query = text(""" CREATE VIEW job_applications_view AS SELECT JOB_APPLICATION.job_id AS ja_job_id, JOB_APPLICATION.caregiver_user_id AS ja_caregiver_user_id, USER.given_name AS caregiver_given_name, USER.surname AS caregiver_surname, JOB_APPLICATION.date_applied AS ja_date_applied, JOB.job_id AS job_id FROM JOB_APPLICATION JOIN CAREGIVER ON CAREGIVER.caregiver_user_id = JOB_APPLICATION.caregiver_user_id JOIN JOB ON JOB.job_id = JOB_APPLICATION.job_id JOIN USeR ON USER.user_id = CAREGIVER.caregiver_user_id; """)
cursor.execute(view_all_query)

select_from_query = text("""
    SELECT * FROM job_applications_view
""")
result = cursor.execute(select_from_query)
for row in result:
    print(f"Job ID:{row[0]}  Caregiver ID:{row[1]}  Applicant's name: {row[2]} {row[3]}  Date applied: {row[4]}  Applied for job:{row[5]}")
    print("\n")

cursor.commit()
#close the session
cursor.close()