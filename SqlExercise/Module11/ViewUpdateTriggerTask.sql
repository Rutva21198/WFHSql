create trigger rrEmployeeUpdate on dbo.vEmployeeDetails insted of update
	as
	begin set no count on;
	declare @empid int = (select EmployeeId from inserted)
	if(Update(DeptId))
		update vEmployeeDetails set DeptId=(select DeptId from inserted) where EmployeeId=@empid
	END;
	if(Update(Name))
		update vEmployeeDetails set Name=(select Name from inserted) where EmployeeId=@empid
	END;
END;

update vEmployeeDetails set Name='Rutva', DeptId=3 where EmployeeId=2;