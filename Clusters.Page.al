page 51020 Clusters
{
    Caption = 'Clusters';
    PageType = List;
    SourceTable = "Cluster Regions";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cluster Code"; Rec."Cluster Code")
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
            action("Cluster Regions")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Cluster Regions";
                RunPageLink = Cluster = field("Cluster Code");
            }
        }
    }
}
