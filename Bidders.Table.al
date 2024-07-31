table 50135 Bidders
{
    fields
    {
        field(1; "Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; Name; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Postal Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; City; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "E-mail"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Telephone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Mobile No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contact Person"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "KBA Bank Code"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "KBA Branch Code"; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Bank account No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Category; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Pre Qualified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Tender Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Bid Security Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "No. of Copies Submitted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Bid Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Ref No.", Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
