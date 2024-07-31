table 50727 "Contract Change Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Contract Extension No.s");
                    NoSeriesMgt.TestManual(PurchSetup."Contract Extension No.s");
                    "No. Series":='';
                end;
            end;
        }
        field(2; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Header";

            trigger OnValidate()
            begin
                if ContractRec.Get("Contract No.")then "Previous End Date":=ContractRec."Estimated End Date";
            //Message((Format("Previous End Date")));
            end;
        }
        field(5; "Previous End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Extension Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Contract No.");
                TestField("Previous End Date");
                "New Contract End Date":=CalcDate("Extension Duration", "Previous End Date");
            end;
        }
        field(7; "New Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Extension Reason"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Change Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Extension, Termination, Suspension;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ContractRec: Record "Project Header";
    trigger OnInsert()
    begin
        "Created By":=UserId;
        "Creation Date":=Today;
        IF "No." = '' THEN BEGIN
            PurchSetup.GET();
            PurchSetup.TESTFIELD(PurchSetup."Contract Extension No.s");
            NoSeriesMgt.InitSeries(PurchSetup."Contract Extension No.s", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
