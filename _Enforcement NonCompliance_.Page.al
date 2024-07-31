page 50947 "Enforcement NonCompliance"
{
    Caption = 'Enforcement NonCompliance';
    PageType = ListPart;
    SourceTable = "Enforcement NonCompliance";
    SourceTableView = where(Type = const(General));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Non-compliance Status';
                }
                field("Milk Volume"; Rec."Milk Volume")
                {
                    ApplicationArea = All;
                    Caption = 'Dairy Produce Quantity';
                }
                field("Action To be Taken"; Rec."Action To be Taken")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Enabled = ShowDeadline;
                }
                field("Compliance Dateline"; Rec."Compliance Dateline")
                {
                    Caption = 'Compliance Date';
                    Enabled = ShowDeadline;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::General;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        ShowDeadline: Boolean;
        ShowJudgement: Boolean;

    procedure SetControlAppearance()
    begin
        if Rec."Action To be Taken" = Rec."Action To be Taken"::"Given timeline to achieve compliance" then
            ShowDeadline := true
        else
            ShowDeadline := false;
        if Rec."Action To be Taken" = Rec."Action To be Taken"::"Proceed to Prosecution" then
            ShowJudgement := true
        else
            ShowJudgement := false;
    end;
}
