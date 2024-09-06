tableextension 50129 SalesInvHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Lease No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Billing No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Property No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Customer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(50005; "Requested Evacuation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "PurchHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Rent Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Property Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Rescheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Rescheduled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Date Rescheduled"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Reschedule Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "TPS Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; Branch; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Branches".Branch where("Customer No." = field("Sell-to Customer No."));
        }
    }
}
