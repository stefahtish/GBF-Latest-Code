table 50542 Contract_WorkRv
{
    fields
    {
        field(1; "Contract No."; Code[30])
        {
            NotBlank = false;
            TableRelation = Contract."Contract No." WHERE("Contract Category"=CONST(Work));
        }
        field(2; "Previous Gross work done Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Previous Gross work done"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Present Gross work done Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Present Gross work done"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cummulative Gross work done"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;

            trigger OnValidate()
            begin
            //"Cummulative Gross work done":="Present Gross work done"+"Previous Gross work done";
            end;
        }
        field(7; "Material on site"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Daywork; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Variation Orders"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Claims; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Price Adjustment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Price Adj Foreign"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Price Adj Local"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Interest on Late Payment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //"Sub-Total(3-9)":="Cummulative Gross work done"+"Material on site"+Daywork+"Variation Orders"+Claims+"Price Adj Local"+"Price Adj Foreign";
            end;
        }
        field(15; "Description Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Prev Retation At 10%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "present Retation At 10%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Cummulative Retation At 10%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
            // "Cummulative Retation At 10%":="Prev Retation At 10%"+"present Retation At 10%";
            // "Sub-Total(10-15)":="Sub-Total(3-9)"+"Cummulative Retation At 10%";
            end;
        }
        field(19; "Retation Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Recovery Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Prev Recovery Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(22; "Prec Recovery Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Total Recovery Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
            //"Total Recovery Advance Payment":="Prev Recovery Advance Payment"+"Prec Recovery Advance Payment";
            end;
        }
        field(24; "Balance of Rec Advance Payment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                "Balance of Rec Advance Payment":="Recovery Advance Payment" - "Total Recovery Advance Payment";
            end;
        }
        field(25; "Cummulative Net Due"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
            //"Cummulative Net Due":="Sub-Total(10-15)"-"Total Recovery Advance Payment";
            end;
        }
        field(26; "Last Certificate No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Schedule"."Schedule No." WHERE("Contract No."=FIELD("Contract No."));
        }
        field(27; "Prev Payment on Last Cert"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Net Due to Contractor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
            //"Net Due to Contractor":="Cummulative Net Due"-"Prev Payment on Last Cert";
            end;
        }
        field(29; "Relaese of 50% Retation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Total Due inc(VAT)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //"Total Due inc(VAT)":="Net Due to Contractor";
            end;
        }
        field(31; "IPC No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Schedule"."Schedule No." WHERE("Contract No."=FIELD("Contract No."));
        }
        field(32; "75% Material on site"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Calculate cost of material"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Last Payment Certificate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; Number; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(37; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Posted,Revesed';
            OptionMembers = New, Posted, Revesed;
        }
        field(38; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Number)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    // IF Number='' THEN BEGIN
    //  HRSetup.TESTFIELD(WorkCont);
    //  NoSeriesMgt.InitSeries(HRSetup.WorkCont,xRec."No. Series",0D,Number,"No. Series");
    //  END;
    end;
    trigger OnModify()
    begin
    // "Last Modified By":=USERID + ' ' + ' on ' + FORMAT(CREATEDATETIME(TODAY,TIME));
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Vendor: Record Vendor;
    GlAccount: Record "G/L Account";
    TEXT000: Label 'Block this Contract %1?';
    TEXT001: Label 'Unblock Contract %1?';
    "Sub-Total(3-9)": Decimal;
    "Sub-Total(10-15)": Decimal;
    HRSetup: Record "Human Resources Setup";
    [Scope('Cloud')]
    procedure CalcBal()
    begin
    // Balance:="Original Contract Price"-"Amount Paid";
    // VALIDATE(Balance);
    end;
}
