query 50104 "Employees-BI"
{
    QueryType = Normal;

    elements
    {
    dataitem(Employee;
    Employee)
    {
    column(No;
    "No.")
    {
    }
    column(Name;
    Name)
    {
    }
    column(BirthDate;
    "Birth Date")
    {
    }
    column(Gender;
    Gender)
    {
    }
    column(JobTitle;
    "Job Title")
    {
    }
    column(JobPosition;
    "Job Position")
    {
    }
    column(JobPositionTitle;
    "Job Position Title")
    {
    }
    column(Status;
    Status)
    {
    }
    column(TotalAllowances;
    "Total Allowances")
    {
    }
    column(TotalDeductions;
    "Total Deductions")
    {
    }
    column(BasicPay;
    "Basic Pay")
    {
    }
    column(CummPAYE;
    "Cumm. PAYE")
    {
    }
    column(CountyCode;
    "County Code")
    {
    }
    column(EmployeeType;
    "Employment Type")
    {
    }
    column(EmploymentType;
    "Employment Type")
    {
    }
    column(DateOfJoin;
    "Date Of Join")
    {
    }
    column(EmployeeJobType;
    "Employee Job Type")
    {
    }
    column(EmploymentDate;
    "Employment Date")
    {
    }
    column(EmploymentStatus;
    "Employment Status")
    {
    }
    column(FirstName;
    "First Name")
    {
    }
    column(GlobalDimension1Code;
    "Global Dimension 1 Code")
    {
    }
    column(GlobalDimension2Code;
    "Global Dimension 2 Code")
    {
    }
    column(LastName;
    "Last Name")
    {
    }
    column(MiddleName;
    "Middle Name")
    {
    }
    column(NetPay;
    "Net Pay")
    {
    }
    column(County;
    County)
    {
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
