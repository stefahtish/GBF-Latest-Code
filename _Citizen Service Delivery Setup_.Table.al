table 50543 "Citizen Service Delivery Setup"
{
    Caption = 'Citizen Service Delivery Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Option)
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Complaint,Enquiry,Media inquiries,LPO,Payments,Dairy Industry Statistics,Import Export Permits,Licenses,Milk';
            OptionMembers = " ", Complaint, Enquiry, Media, LPO, Payments, Dairy, Imports, Licenses, Milk;
        }
        field(2; "Service Rendered"; Blob)
        {
            Caption = 'Service Rendered';
            DataClassification = ToBeClassified;
        }
        field(3; Requirement; Text[2048])
        {
            Caption = 'Requirement';
            DataClassification = ToBeClassified;
        }
        field(4; Charges; Text[2000])
        {
            Caption = 'Charges';
            DataClassification = ToBeClassified;
        }
        field(5; Timelines; Text[2000])
        {
            Caption = 'Timelines';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Category)
        {
            Clustered = true;
        }
    }
}
