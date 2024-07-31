tableextension 50120 SalesHeaderExt extends "Sales Header"
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
        field(9409; "Customer Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(9550; "Requested Evacuation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9551; "PurchHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9552; "Rent Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9553; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9554; "Property Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9555; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9556; "Schedule Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9557; Rescheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9558; "Rescheduled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9559; "Date Rescheduled"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9560; "Reschedule Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9561; "TPS Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9562; Branch; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Branches".Branch where("Customer No."=field("Sell-to Customer No."));
        }
        field(9563; "License Applicant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9564; "Project Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
