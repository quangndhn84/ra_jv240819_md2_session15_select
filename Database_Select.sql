-- 1. Lấy ra ngày hiện tại của hệ thống
select current_date();
-- Tạo CSDL quản lý sinh viên
create database Student_Management_DB;
use Student_Management_DB;
create table Class(
	class_id int primary key auto_increment,
    class_name varchar(100) not null unique,
    class_status bit
);
create table Student(
	student_id char(5) primary key,
    class_id int,
    foreign key(class_id) references Class(class_id),
    student_name varchar(100) not null,
    student_age int check(student_age>=18),
    -- 0: Female, 1: Male
    student_sex bit,
    -- 0: nghỉ học, 1 - đang học
    student_status bit default(1)
);
insert into Class(class_name, class_status)
	values('FUK_JV240819',1),('PT_JV240919',1),('FUK_JV240711',0),('FT_JV241201', 0);
insert into Student
	values('SV001',1, 'Nguyễn Thị Hoàng Giang', 18, 0, 1),
			('SV002',1, 'Lê Văn A', 22, 1, 1),
            ('SV003',2, 'Nguyễn Văn B', 20, 1, 0),
            ('SV004',2, 'Trần Hồng Hạnh', 21, 0, 0),
            ('SV005',1, 'Nguyễn Văn C', 19, 1, 1),
            ('SV006',3, 'Nguyễn Văn E', 25, 0, 1),
            ('SV007',1, 'Nguyễn Văn D', 24, 1, 0);
select * from Class;
select * from Student;
-- 2.Lấy tất thông tin sinh viên trong bảng student: * lấy tất cả thông tin
select *
from student;
-- 3. Lấy thông tin mã sinh viên, tên sinh viên, tuổi: fieldName
select sv.student_id, sv.student_name, sv.student_age
from student sv;
-- SELECT: sử dụng các hàm tính toán
-- 4. Lấy ra tuổi lớn nhất, nhỏ nhất, tổng tuổi, tuổi trung bình của các sinh viên
select max(sv.student_age) as 'MaxAge', min(sv.student_age) as 'MinAge', sum(sv.student_age), avg(sv.student_age)
from student sv;
-- SELECT: distinct - lấy các sử liệu không trùng lặp
-- 5. Lấy ra các mã lớp mà đã có sinh viên
select distinct sv.class_id
from student sv;
-- FROM: lấy dữ liệu từ 1 bảng hoặc nhiều bảng
/*
	INNER JOIN (JOIN): Lấy phần chung giữa 2 bảng
    LEFT JOIN: Lấy phần chung và dữ liệu bảng bên trái
    RIGHT JOIN: Lấy phần chung và dữ liệu bảng bên phải
*/
insert into Student
	values('SV008',null, 'Nguyễn Duy Quang', 41, 1, 0);
-- 6. Lấy thông tin sinh viên gồm: Mã, tên, tuổi, mã lớp học, tên lớp học
select sv.student_id, sv.student_name, sv.student_age, c.class_id, c.class_name
from student sv inner join class c on sv.class_id = c.class_id;
-- 7. Lây thông tin sinh viên gồm: mã, tên, tuổi, mã lớp học, tên lớp học và các sinh viên chưa thuộc lớp học
select sv.student_id, sv.student_name, sv.student_age, c.class_id, c.class_name
from student sv left join class c on sv.class_id = c.class_id;
-- 7. Lây thông tin sinh viên gồm: mã, tên, tuổi, mã lớp học, tên lớp học và các lớp chưa có sinh viên
select sv.student_id, sv.student_name, sv.student_age, c.class_id, c.class_name
from student sv right join class c on sv.class_id = c.class_id;
-- WHERE: Biểu thức điều kiện lấy dữ liệu: and, or, not
-- 8. Lấy tất cả thông tin sinh viên có tuổi trong khoảng từ 22 đến 24
select *
from student sv
where sv.student_age>=22 and sv.student_age<=24;
-- WHERE: between a and b: nằm trong khoảng a,b và lấy cả 2 đầu mút
-- 9. Lấy thông tin sinh viên có tuổi trong khoảng 19 đến 22
select *
from student sv
where sv.student_age between 19 and 22;
-- WHERE: IN (a,b,c): là 1 trong các giá trị a,b,c
-- 10. Lấy thông tin sinh viên có tuổi 19, 20 hoặc 24
select *
from student sv
where sv.student_age in (19,20,24);
-- WHERE: Like so sáng với chuỗi: %-đại diện cho 0,1 hoặc nhiều ký tự, _ đại diện cho 1 ký tự
-- 11. Lấy tất cả thông tin của sinh viên có tên là Nguyễn Duy Quang
select *
from student sv
where sv.student_name like 'Nguyễn Duy Quang';
-- 12. Lấy thông tin sinh viên có tên bắt đầu là Nguyễn
select *
from student sv
where sv.student_name like 'Nguyễn%';
-- 13. Lấy thông tin sinh viên có ký tự thứ 2 là ê
select * 
from student sv
where sv.student_name like '_ê%';
-- GROUP BY: nhóm dữ liệu và tính toán dữ liệu trên các nhóm
-- 14. Tính độ tuổi trung bình của các lớp: mã lớp, tên lớp, tuổi trung bình của lớp
select sv.class_id, c.class_name, avg(sv.student_age)
from Student sv join class c on sv.class_id = c.class_id
group by sv.class_id;
-- HAVING: Điều kiện nhóm (điều kiện để lọc các nhóm)
-- 15. Lấy mã lớp, tên lớp, tuổi trung bình của các lớp có tuổi trung bình lớn hơn 20.5
select sv.class_id, c.class_name, avg(sv.student_age)
from Student sv join class c on sv.class_id = c.class_id
group by sv.class_id
having avg(sv.student_age) >20.5;
-- ORDER BY: Sắp xếp theo các tiêu chí (ASC - defaut: tăng dần, DESC: giảm dần)
-- 16. Lấy thông tin sinh viên sắp xếp theo tuổi tăng dần
select *
from student sv
order by sv.student_age DESC;
insert into Student
	values('SV009',1, 'Nguyễn Minh Hạnh', 22, 0, 1),
			('SV010',1, 'Le Văn Tùng', 22, 1, 1);
-- 17. Lấy thông tin sinh viên có tuổi giảm dần, những sinh viên bằng tuổi được sắp xếp theo tên tăng dần
select *
from student sv
order by sv.student_age DESC, sv.student_name;
-- LIMIT: Lấy bao nhiêu dữ liệu
-- 18: Lấy thông tin 3 sinh viên đầu trong bảng student
select *
from student
limit 3;
-- OFFSET: lấy từ vị trí bao nhiêu
-- 19. Lấy thông tin 2 sinh viên từ vị trí có chỉ mục là 3
select *
from student
limit 2 offset 3;
-- TRUY VẤN LỒNG (NÂNG CAO): kết quả của câu lệnh truy vấn này là đầu vào của câu lệnh truy vấn khác
-- 20. Lấy thông tin các sinh viên trong lớp có tên là 'FUK_JV240819' và 'PT_JV240919'
-- C1: Sử dụng join
select *
from student sv join class c on sv.class_id = c.class_id
where c.class_name in ('FUK_JV240819', 'PT_JV240919');
-- C2: Dùng truy vấn lồng: S1: lấy ra các mã lớp thỏa mãn --> S2: lấy thông tin sinh viên thuộc các mã lớp đó
select *
from student sv
where sv.class_id in
(select c.class_id
from class c
where c.class_name in ('FUK_JV240819', 'PT_JV240919'));
	
