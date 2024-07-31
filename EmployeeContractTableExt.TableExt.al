tableextension 50102 EmployeeContractTableExt extends "Employment Contract"
{
    fields
    {
        field(50001; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustees';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustees;
        }
        field(50002; "Annual Leave Days"; Decimal)
        {
        }
        field(50003; "Period Leave Days"; Decimal)
        {
        }
        field(50004; "Allocate Periodically"; Boolean)
        {
        }
        field(50005; "Tenure"; DateFormula)
        {
        }
    }
}
