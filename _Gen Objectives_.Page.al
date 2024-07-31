page 51053 "Gen Objectives"
{
    Caption = 'Objectives';
    PageType = ListPart;
    SourceTable = "Partnerships Activity Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patnership line type"; Rec."Patnership line type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Objectives';
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Outcome; Rec.Outcome)
                {
                    caption = 'Output';
                    Visible = Submitted;
                    ApplicationArea = All;
                }
                field("Quantification of outcome"; Rec."Quantification of outcome")
                {
                    caption = 'Rating/Remarks';
                    Visible = Submitted;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        Submitted: Boolean;

    procedure SetControlAppearance()
    var
        ResearchWp: Record "Research Activity Plan";
        Patnership: Record "Partnerships Activity Plan";
    begin
        Submitted := false;
        ResearchWp.Reset();
        ResearchWp.SetRange(Code, Rec.Code);
        if ResearchWp.FindFirst() then begin
            if ResearchWp.Submitted = true then Submitted := true;
        end;
        Patnership.Reset();
        Patnership.SetRange(Code, Rec.Code);
        if Patnership.FindFirst() then begin
            if Patnership.Submitted = true then Submitted := true;
        end;
    end;
}
