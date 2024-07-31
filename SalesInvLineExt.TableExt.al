tableextension 50130 SalesInvLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Lease No."; Code[20])
        {
        }
        field(50001; "Property No."; Code[20])
        {
        }
        field(50002; "Property Floor"; Code[40])
        {
        }
        field(50003; "Property Unit"; Code[40])
        {
        }
        field(50004; "Previous Readings"; Decimal)
        {
        }
        field(50005; "Current Readings"; Decimal)
        {
        }
        field(50006; "Consumption Amount"; Decimal)
        {
        }
        field(50007; "Area Square ft"; Decimal)
        {
        }
        field(50008; "Currently monthly Rent"; Decimal)
        {
        }
        field(50009; "Current Service Charge"; Decimal)
        {
        }
        field(50010; Total; Decimal)
        {
        }
        field(50011; "Rent/S.Charge Rate"; Decimal)
        {
        }
        field(50012; "Charge No."; Code[40])
        {
        }
        field(50013; "Service Charge"; Boolean)
        {
        }
        field(50014; Rent; Boolean)
        {
        }
        field(50015; Branch; Code[100])
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
            TableRelation = "Customer Branches" where("Customer No."=field("Bill-to Customer No."));
        }
    }
    var
}
