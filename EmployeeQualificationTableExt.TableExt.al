tableextension 50105 EmployeeQualificationTableExt extends "Employee Qualification"
{
    fields
    {
        field(50000; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(50001; Qualification; Text[200])
        {
        }
        field(50002; Score; Decimal)
        {
        }
        field(50003; Grade; Text[40])
        {
        }
    }
}
