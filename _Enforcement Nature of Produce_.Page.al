page 51018 "Enforcement Nature of Produce"
{
    Caption = 'Enforcement Nature of Produce';
    PageType = ListPart;
    SourceTable = "Enforcement Nature of Produce2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Nature of Produce"; Rec."Nature of Produce")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Other"; Rec."Others")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Specify"; Rec."Specify")
                {
                    ApplicationArea = All;
                    Enabled = OtherTrue;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    procedure SetControlAppearance()
    begin
        if not Rec.Others then begin
            OtherTrue := false;
        end
        else
            OtherTrue := True;
    end;

    var
        OtherTrue: Boolean;
}
