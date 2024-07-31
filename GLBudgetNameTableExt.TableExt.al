tableextension 50116 GLBudgetNameTableExt extends "G/L Budget Name"
{
    fields
    {
        field(50000; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(50001; "Total Budget Allocation"; Decimal)
        {
            CalcFormula = Sum("Procurement Plan"."Estimated Cost" WHERE("Plan Year"=FIELD(Name), "Department Code"=FIELD("Department Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50100; "Total Training Allocation"; Decimal)
        {
            CalcFormula = Sum("Training Budget"."Approved Budget" WHERE("Training Year"=FIELD(Name)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Budget Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
        }
        field(50003; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Budget Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Budgeting,ReAllocation';
            OptionMembers = " ", Budgeting, ReAllocation;
        }
        field(50005; "Current Year"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
