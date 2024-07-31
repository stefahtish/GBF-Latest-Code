table 50354 "Annual Asset Disposal Lines"
{
    Caption = 'Asset Disposal Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "FA No."; Code[10])
        {
            Caption = 'FA No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Marked For Disposal"=const(false));

            trigger OnValidate()
            var
                FALedger: Record "FA Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                CurrenntYearStart: Date;
                fa: Record "Fixed Asset";
                DisposalPlan: Record "Annual Asset Disposal Lines";
            begin
                DisposalPlan.Reset();
                DisposalPlan.SetFilter("No.", '<>%1', "No.");
                DisposalPlan.SetRange("FA No.", "FA No.");
                if DisposalPlan.FindFirst()then Error('This asset has been selected for disposal in another plan %1', DisposalPlan."No.");
                fa.get("FA No.");
                "FA Name":=FA.Description;
                FA.Calcfields(NetBookValue);
                AccountingPeriod.RESET;
                AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
                AccountingPeriod."Starting Date":=WORKDATE;
                if AccountingPeriod.FIND('=<')then CurrenntYearStart:=AccountingPeriod."Starting Date";
                FALedger.Reset();
                FALedger.SetRange(FALedger."FA No.", "FA No.");
                FALedger.SetRange("Part of Book Value", true);
                FALedger.SetFilter("Posting Date", '<%1', CurrenntYearStart);
                if FALedger.Find('-')then begin
                    FALedger.CalcSums(Amount);
                    "Estimated Current Value":=FALedger.Amount;
                end;
                FALedger.Reset();
                FALedger.SetRange(FALedger."FA No.", "FA No.");
                FALedger.SetRange("FA Posting Type", FALedger."FA Posting Type"::"Acquisition Cost");
                if FALedger.FindFirst()then begin
                    "Acquisition Date":=FALedger."Posting Date";
                    FALedger.CalcSums(Amount);
                    "Original Purchase Value":=FALedger.Amount;
                end;
                IF "Estimated Current Value" = 0 then "Estimated Current Value":=FA.NetBookValue;
            end;
        }
        field(3; "FA Name"; Text[100])
        {
            Caption = 'FA Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Reasons for disposal"; Text[2048])
        {
            Caption = 'Reasons for disposal';
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(6; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(7; Condition; Text[1000])
        {
            Caption = 'Condition';
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Pending, Approved;
        }
        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Estimated Current Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Asset Condition";Enum "Asset Conditions")
        {
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Human Resource Unit of Measure";
        }
        field(14; "Acquisition Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Original Purchase Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Disposal Initiation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Bid Documents Prepared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Invitation To Tender"; Date)
        {
            Caption = 'Invitation To Tender/Public Auction';
            DataClassification = ToBeClassified;
        }
        field(19; "Bid Opening"; Date)
        {
            Caption = 'Bid Opening/ Registration of Bidders';
            DataClassification = ToBeClassified;
        }
        field(20; "Accounting officer Award"; Date)
        {
            Caption = 'Accounting officer Award/ Fall of Auction Hammer';
            DataClassification = ToBeClassified;
        }
        field(21; "Item Life span"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Notification of Award"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Contract Signed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Disposal Completed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Notice to PPRA"; Date)
        {
            Caption = 'Notice to PPRA (if Disposal to Employee)';
            DataClassification = ToBeClassified;
        }
        field(26; "Cost of managing disposal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Disposal Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Justification for disposal"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Ref. No to the asset register "; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Disposal Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Asset Disposal Methods";

            trigger OnValidate()
            var
                AssetDisposal: Record "Asset Disposal Methods";
            begin
                AssetDisposal.Reset();
                AssetDisposal.SetRange(Code, "Disposal Method Code");
                if AssetDisposal.FindFirst()then "Disposal Method":=AssetDisposal.Description;
            end;
        }
    }
    keys
    {
        key(PK; "No.", "FA No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
    // if not CashSetup.Get() then begin
    //     CashSetup.Init();
    //     CashSetup.Insert();
    // end;
    // CashSetup.Get();
    // CashSetup.TestField("Annual FA Disposal Plan Nos");
    // NoSeriesMgt.InitSeries(CashSetup."Annual FA Disposal Plan Nos", xRec."No. Series", Today, "No.", "No. Series");
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    CashSetup: Record "Cash Management Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure MarkAssetForDisposals()
    var
        FA: Record "Fixed Asset";
    begin
        FA.SetRange("No.", "FA No.");
        if FA.FindFirst()then begin
            FA."Marked For Disposal":=true;
            FA.Modify();
        end;
    end;
}
