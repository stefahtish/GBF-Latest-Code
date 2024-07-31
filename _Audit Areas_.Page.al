page 51177 "Audit Areas"
{
    Caption = 'Audit Areas';
    PageType = ListPart;
    SourceTable = "Audit Areas";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit plan area"; Rec."Audit plan area")
                {
                    caption = 'Audit Area';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Subsections")
            {
                Image = Process;
                RunObject = page "Audit Area Subsections";
                RunPageLink = "No." = field("No."), "Audit plan area" = field("Audit plan area");
            }
        }
    }
}
