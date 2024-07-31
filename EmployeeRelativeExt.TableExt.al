tableextension 50106 EmployeeRelativeExt extends "Employee Relative"
{
    fields
    {
        field(50000; Dependant; Boolean)
        {
        }
        field(50001; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ", Male, Female;
        }
        field(50002; "Dependant No"; Code[20])
        {
        }
    }
}
