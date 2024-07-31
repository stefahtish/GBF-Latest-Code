table 50481 "Email/SMS Logging Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Last Date Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(5; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Total Items"; Integer)
        {
            CalcFormula = Count("Email/SMS Logging Lines" WHERE("No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Total Sent"; Integer)
        {
            CalcFormula = Count("Email/SMS Logging Lines" WHERE(Sent=FILTER(true), "No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Pending,Complete';
            OptionMembers = Pending, Complete;
        }
        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document Email Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Statement,Contributions Reconciliation,Client Notifications';
            OptionMembers = Statement, "Contributions Reconciliation", "Client Notifications";
        }
        field(11; "Communication Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'E-Mail,SMS,E-Mail & SMS';
            OptionMembers = "E-Mail", SMS, "E-Mail & SMS";
        }
        field(13; "Report Selected"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Email Report Selections Custom"."Report ID" WHERE(Usage=FIELD("Document Email Type"));
        }
        field(14; "Report Selected Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "E-Mail Body Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "SMS Body Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "E-Mail Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Attachment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "HTML Formatted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            InteractSetup.Get;
            InteractSetup.TestField("Client Commuication Nos.");
            NoSeriesMgt.InitSeries(InteractSetup."Client Commuication Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Last Date Modified":=CreateDateTime(Today, Time);
        "Last Modified By":=UserId;
    end;
    trigger OnModify()
    begin
        "Last Date Modified":=CreateDateTime(Today, Time);
        "Last Modified By":=UserId;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    SMSMessage: Text;
    InteractSetup: Record "Interaction Setup";
    local procedure SendSMS(SMSSenderID: Text; PhoneNo: Code[20]; SMSMessage: Text)
    begin
    end;
}
