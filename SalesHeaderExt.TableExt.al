tableextension 50120 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(60000; "Lease No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Billing No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Property No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Customer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(60005; "Requested Evacuation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "PurchHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "Rent Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Property Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60011; "Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60012; Rescheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60013; "Rescheduled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60014; "Date Rescheduled"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Reschedule Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "TPS Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60017; Branch; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Branches".Branch where("Customer No." = field("Sell-to Customer No."));
        }
        field(60018; "License Applicant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "Project Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
