table 50226 "Company Activities"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Day; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Venue; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Responsibility; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Employee.Get(Responsibility)then begin
                    Name:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(6; Costs; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "G/L Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Bal. Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Bank';
            OptionMembers = "G/L Account", Bank;

            trigger OnValidate()
            begin
            //{
            //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
            //GLAccts.GET(GLAccts."No.")
            //ELSE
            //Banks.GET(Banks."No.");
            //}
            end;
        }
        field(9; "Bal. Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(10; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(12; "Attachment No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Language Code (Default)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(14; Attachement; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No, Yes;
        }
        field(15; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Unit of measure"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Human Resource Unit of Measure";
        }
        field(18; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
}
