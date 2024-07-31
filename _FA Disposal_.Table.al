table 50170 "FA Disposal"
{
    Caption = 'FA Disposal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CashMgt.get;
                    CashMgt.TestField("FA Disposal Nos");
                    NoSeriesMgt.TestManual(CashMgt."FA Disposal Nos");
                end;
            end;
        }
        field(2; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(3; "Date-Time Created"; DateTime)
        {
            Caption = 'Date-Time Created';
            DataClassification = ToBeClassified;
        }
        field(4; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(5; Status;Enum "Approval Status-custom")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(6; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(7; "Staff No."; Code[50])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Staff No.")then begin
                    "Staff Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    Department:=Emp."Global Dimension 2 Code";
                end;
            end;
        }
        field(8; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = ToBeClassified;
        }
        field(9; Department; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Lot No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Quotation Deadline"; Date)
        {
            Caption = 'Closing Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Submitted To Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Expected Closing Time"; Time)
        {
            Caption = 'Closing Time';
            DataClassification = ToBeClassified;
        }
        field(14; "Quote generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Comments)
        {
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            CashMgt.get;
            CashMgt.TestField("FA Disposal Nos");
            NoSeriesMgt.InitSeries(CashMgt."FA Disposal Nos", xRec."No. Series", 0D, "No.", "No. Series")end;
        // if "Lot No." = '' then begin
        //     CashMgt.get;
        //     CashMgt.TestField("Lot nos");
        //     NoSeriesMgt.InitSeries(CashMgt."Lot nos", xRec."No. Series", 0D, "Lot No.", "No. Series")
        // end;
        if UserSetup.Get(UserId)then begin
            UserSetup.TestField("Employee No.");
            "Staff No.":=UserSetup."Employee No.";
            if Emp.Get("Staff No.")then begin
                "Staff Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                Department:=Emp."Global Dimension 2 Code";
            end;
        end
        else
            Error('Please set up user in User Setup');
        "Date-Time Created":=CurrentDateTime;
        "Created By":=UserId;
    end;
    var UserSetup: Record "User Setup";
    Emp: Record Employee;
    CashMgt: Record "Cash Management Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
