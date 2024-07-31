tableextension 50137 ActivitiesCueExt extends "Activities Cue"
{
    fields
    {
        field(50000; "Pending Imprest"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER(Imprest), Status=FILTER("Pending Approval"), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(50001; "Pending Staff Claim"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER("Staff Claim"), Status=FILTER("Pending Approval"), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(50002; "Pending Imprest Surrender"; Integer)
        {
            CalcFormula = Count(Payments WHERE("Payment Type"=FILTER("Imprest Surrender"), Status=FILTER("Pending Approval"), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(50003; "Pending Store Requisition"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=FILTER(Purchase), Status=FILTER("Pending Approval"), Posted=CONST(false)));
            FieldClass = FlowField;
        }
        field(50004; "Pending Purchase Requisition"; Integer)
        {
            CalcFormula = Count("Internal Request Header" WHERE("Document Type"=CONST(Purchase), Status=CONST("Pending Approval"), Posted=CONST(false)));
            FieldClass = FlowField;
        }
    }
}
