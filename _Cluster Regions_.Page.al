page 51021 "Cluster Regions"
{
    Caption = 'Cluster Regions';
    PageType = List;
    SourceTable = "Cluster Regions Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Region code"; Rec."Region code")
                {
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
