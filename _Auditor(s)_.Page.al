page 50922 "Auditor(s)"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Auditor; Rec.Auditor)
                {
                }
                field("Auditor Name"; Rec."Auditor Name")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
