table 50171 "FA Disposal Line"
{
    Caption = 'FA Disposal Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "FA No."; Code[50])
        {
            Caption = 'FA No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where("Marked For Disposal"=const(true), Disposed=const(false), Acquired=const(true));

            trigger OnValidate()
            var
                FALedger: Record "FA Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                CurrenntYearStart: Date;
            begin
                fa.get("FA No.");
                "Subclass Code":=FA."FA Subclass Code";
                "Department Code":=FA."Global Dimension 2 Code";
                "Location Code":=FA."Location Code";
                Description:=FA.Description;
                "Entry Date":=Today;
                Validate(Description);
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
                    FALedger.CalcSums(Amount);
                    "Original Purchase Value":=FALedger.Amount;
                end;
                IF "Estimated Current Value" = 0 then "Estimated Current Value":=FA.NetBookValue;
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                FAHeader: Record "FA Disposal";
                myInt: Integer;
            begin
                FAHeader.Reset();
                FAHeader.SetRange("No.", "Document No.");
                if FAHeader.FindFirst()then begin
                    if FAHeader."Lot No." = '' then begin
                        "Lot No.":=format(Date2DMY(Today, 3)) + "Subclass Code" + "Location Code" + GetNextNo();
                        FAHeader."Lot No.":="Lot No.";
                        FAHeader.Modify();
                    end
                    else
                        "Lot No.":=FAHeader."Lot No.";
                end;
            end;
        }
        field(5; Bids; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request Lines" where("FA Disposal Doc No."=field("Document No."), No=field("FA No."), "Line No"=field("Line No."), "Bid Submitted"=const(true)));
            Editable = false;
        }
        field(6; "Highest Bid"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = max("Procurement Request Lines".Amount where("FA Disposal Doc No."=field("Document No."), No=field("FA No."), "Line No"=field("Line No."), "Bid Submitted"=const(true)));
            Editable = false;
        }
        field(7; "Fixed Asset Register No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Acquisition Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Original Purchase Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Estimated Current Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Condition;Enum "Asset Conditions")
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
        field(14; "Lot No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Last No. Used"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Subclass Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Entry Date":=Today;
    end;
    var FA: Record "Fixed Asset";
    local procedure GetNextNo(): Code[50]var
        FADisposalRec: Record "FA Disposal Line";
        StartDate: Date;
        EndDate: Date;
        NextNo: Code[50];
    begin
        StartDate:=CALCDATE('<-CY>', "Entry Date");
        EndDate:=CALCDATE('<CY>', "Entry Date");
        FADisposalRec.Reset();
        FADisposalRec.SetRange("Subclass Code", "Subclass Code");
        FADisposalRec.SetRange("Department Code", "Department Code");
        FADisposalRec.SetRange("Entry Date", StartDate, EndDate);
        FADisposalRec.SetFilter("Last No. Used", '<>%1', ' ');
        if FADisposalRec.FindLast()then begin
            NextNo:=IncStr(FADisposalRec."Last No. Used");
            "Last No. Used":=NextNo;
            exit(NextNo);
        end
        else
        begin
            NextNo:='01';
            "Last No. Used":=NextNo;
            exit(NextNo);
        end;
    end;
}
