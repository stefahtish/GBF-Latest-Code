page 51048 "Stake. Support Activity Plans"
{
    Caption = 'Capacity building';
    PageType = List;
    CardPageId = "Stake. Support Activity Plan";
    SourceTable = "Research Activity Plan";
    SourceTableView = WHERE("Research Type" = CONST(Support));
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
                }
                field("Support Activity Type"; Rec."Support Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Description of activity"; Rec."Description of activity")
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
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Subcounty; Rec.Subcounty)
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
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
