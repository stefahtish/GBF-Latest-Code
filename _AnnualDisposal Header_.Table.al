table 50352 "AnnualDisposal Header"
{
    Caption = 'AnnualDisposal Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Created by"; Code[50])
        {
            Caption = 'Created by';
            DataClassification = ToBeClassified;
        }
        field(3; "Accounting Period"; Date)
        {
            Caption = 'Accounting Period';
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Year:=Date2DMY("Accounting Period", 3);
            end;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(5; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(6; Status;Enum "Approval Status-custom")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(7; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[50])
        {
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.get;
            PurchSetup.TestField("Annual Asset Disposal Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Annual Asset Disposal Nos", xRec."No. Series", 0D, "No.", "No. Series")end;
        // if "Lot No." = '' then begin
        //     CashMgt.get;
        //     CashMgt.TestField("Lot nos");
        //     NoSeriesMgt.InitSeries(CashMgt."Lot nos", xRec."No. Series", 0D, "Lot No.", "No. Series")
        // end;
        if UserSetup.Get(UserId)then begin
        end
        else
            Error('Please set up user in User Setup');
        "Date Created":=Today;
        "Created By":=UserId;
    end;
    var UserSetup: Record "User Setup";
    Emp: Record Employee;
    PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
