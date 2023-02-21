-- task 1
select course.title
from course
where credits = 3 and dept_name = 'Comp. Sci.';

-- task 2
select takes.course_id, course.title
from takes join course
    on takes.course_id = course.course_id
where takes.ID = '12345';

-- task 3
select sum(course.credits)
from takes join course
    on takes.course_id = course.course_id
where takes.ID = '12345';

-- task 4
select takes.ID, sum(course.credits)
from takes join course
    on takes.course_id = course.course_id
group by takes.ID;

-- task 5
select distinct takes.ID
from takes join course
    on takes.course_id = course.course_id
where dept_name = 'Comp. Sci.';

-- task 6
select instructor.ID
from instructor
where instructor.ID not in
(select distinct ID from teaches);

-- task 7
select instructor.ID, instructor.name
from instructor
where instructor.ID not in
(select distinct ID from teaches);

-- task 1.1
select max(enrollment), min(enrollment) from
(select count(sec_id) as enrollment
from takes
group by sec_id, course_id, semester, year) as en;

-- optional
-- 1
select takes.ID
from takes
where takes.grade = 'F%'
group by takes.ID, course_id
having min(grade) > 'F';



