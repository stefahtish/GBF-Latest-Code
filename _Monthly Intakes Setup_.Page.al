page 51028 "Monthly Intakes Setup"
{
    Caption = 'Monthly Intakes Setup';
    PageType = List;
    SourceTable = "Monthly Return Intake Setup2";
    SourceTableView = SORTING("Line No.");
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = NameEmphasize;

                    trigger Onvalidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = NameEmphasize;

                    trigger Onvalidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.Update();
                    end;
                }
                field(units; Rec.units)
                {
                    ApplicationArea = All;
                    Enabled = NoEmphasize;
                }
                field(Others; Rec.Others)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SetcontrolAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetcontrolAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetcontrolAppearance();
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;

    procedure SetcontrolAppearance()
    var
        myInt: Integer;
        i: Integer;
    begin
        if Rec."Type" = Rec."Type"::Heading then
            NameEmphasize := true
        else
            NameEmphasize := false;
        if Rec."Type" = Rec."Type"::SubHeading then
            NoEmphasize := true
        else
            NoEmphasize := false;
    end;
}
