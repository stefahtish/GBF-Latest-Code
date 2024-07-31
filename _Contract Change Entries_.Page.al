page 50739 "Contract Change Entries"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract Change Entries";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Change No."; Rec."Change No.")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}
