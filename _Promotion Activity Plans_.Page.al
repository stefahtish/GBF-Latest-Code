page 51045 "Promotion Activity Plans"
{
    Caption = 'Promotion Activity Plans';
    PageType = List;
    CardPageId = "Promotion Activity Plan";
    SourceTable = "Research Activity Plan";
    SourceTableView = WHERE("Research Type" = CONST(Export));
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
                field("Export Activity Type"; Rec."Export Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Description of activity"; Rec."Description of activity")
                {
                    ApplicationArea = All;
                }
                field("Type of participants"; Rec."Type of participants")
                {
                    ApplicationArea = All;
                }
                field("Target Number of participants"; Rec."Target Number of participants")
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
}
