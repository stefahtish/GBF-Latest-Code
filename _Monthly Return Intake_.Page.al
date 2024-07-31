page 51026 "Monthly Return Intake"
{
    Caption = 'Monthly Return Intake';
    PageType = ListPart;
    SourceTable = "Monthly Returns intake";
    SourceTableView = SORTING("Line No.");
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Others; Rec.Others)
                {
                    Enabled = IsOther;
                    Caption = 'Others (Specify)';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger Onvalidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Units; Rec.Units)
                {
                    ApplicationArea = All;
                    //  Enabled = NoEmphasize;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    //  Enabled = NoEmphasize;
                }
                field("Unit Cost per litre"; Rec."Unit Cost per litre")
                {
                    ApplicationArea = All;
                }
                field("Cost(Ksh.)"; Rec."Cost(Ksh.)")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    //Enabled = NoEmphasize;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // SetcontrolAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // SetcontrolAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // SetcontrolAppearance();
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        IsOther: Boolean;

    procedure SetcontrolAppearance()
    var
        myInt: Integer;
        i: Integer;
        Intakes: Record "Monthly Return Intake Setup2";
    begin
        // if "Type" = "Type"::Heading then begin
        //     NameEmphasize := true;
        //     Units := '';
        // end else
        //     NameEmphasize := false;
        // if "Type" = "Type"::SubHeading then
        //     NoEmphasize := true
        // else
        // NoEmphasize := false;
        Intakes.Reset();
        Intakes.SetRange(Description, Rec.Description);
        Intakes.SetRange(Others, true);
        if Intakes.FindFirst() then
            IsOther := true
        else
            IsOther := true;
    end;
}
