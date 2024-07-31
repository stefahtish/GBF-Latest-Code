page 50849 "Interaction Resolutions"
{
    PageType = Card;
    SourceTable = "Interaction Resolution";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("Interaction No."; Rec."Interaction No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Cause No."; Rec."Cause No.")
                {
                }
                field(Cause; Rec.Cause)
                {
                }
            }
            part(Control1000000012; "Resolution Steps List")
            {
                SubPageLink = "Interaction Resol. Code" = FIELD("No.");
            }
        }
    }
    actions
    {
    }
}
