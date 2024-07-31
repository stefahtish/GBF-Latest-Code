page 50362 "Customer Branches"
{
    Caption = 'Customer Branches';
    PageType = List;
    SourceTable = "Customer Branches";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Category of outlets"; Rec."Category of outlets")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Subcounty; Rec.Subcounty)
                {
                    ApplicationArea = All;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Station; Rec.Station)
                {
                    Caption = 'Branch';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Contact person"; Rec."Contact person")
                {
                    ApplicationArea = All;
                }
                field(Salutation; Rec.Salutation)
                {
                }
                field("Telephone No"; Rec."Telephone No")
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
            action(Products)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "License Applicant Products";
                RunPageLink = "Application no" = field("Applicant No");
            }
        }
    }
}
