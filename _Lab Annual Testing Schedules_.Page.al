page 50954 "Lab Annual Testing Schedules"
{
    Caption = 'Workplan List';
    PageType = List;
    Editable = false;
    CardPageId = "Lab Annual Testing Schedule";
    SourceTable = "Lab Annual Testing Schedule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Market; Rec.Market)
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
