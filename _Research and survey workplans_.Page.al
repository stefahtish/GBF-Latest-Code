page 51056 "Research and survey workplans"
{
    Caption = 'Research and Survey Workplan list';
    PageType = List;
    CardPageId = "Research and survey workplan";
    SourceTable = "Research and survey Workplan";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Name of research"; Rec."Name of research")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
