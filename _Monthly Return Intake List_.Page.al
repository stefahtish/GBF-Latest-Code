page 51032 "Monthly Return Intake List"
{
    Caption = 'Monthly Return Intake';
    PageType = List;
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

                    // Style = Strong;
                    // StyleExpr = NameEmphasize;
                    trigger Onvalidate()
                    begin
                        // SetcontrolAppearance();
                        // CurrPage.Update();
                    end;
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
                    // Enabled = NoEmphasize;
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
        //SetcontrolAppearance();
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
        if Rec."Type" = Rec."Type"::Heading then begin
            NameEmphasize := true;
            Rec.Units := '';
        end
        else
            NameEmphasize := false;
        if Rec."Type" = Rec."Type"::SubHeading then
            NoEmphasize := true
        else
            NoEmphasize := false;
    end;
}
