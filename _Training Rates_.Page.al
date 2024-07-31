page 50575 "Training Rates"
{
    PageType = List;
    SourceTable = "Destination Rate Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;

                field("Employee Job Group"; Rec."Employee Job Group")
                {
                }
                field("Advance Code"; Rec."Advance Code")
                {
                }
                field("Daily Rate (Amount)"; Rec."Daily Rate (Amount)")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Destination Type"; Rec."Destination Type")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Rate Type" := Rec."Rate Type"::Training;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Rate Type" := Rec."Rate Type"::Training;
    end;
}
