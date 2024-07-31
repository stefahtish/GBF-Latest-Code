page 50990 Contract_Card
{
    PageType = Card;
    SourceTable = Contract1;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    ShowMandatory = true;
                }
                field("Contract Name"; Rec."Contract Name")
                {
                    ShowMandatory = true;
                }
                field("Contract Category"; Rec."Contract Category")
                {
                    ShowMandatory = true;
                }
                field("Project Manager"; Rec."Project Manager")
                {
                }
                field("Title Of Assignment"; Rec."Title Of Assignment")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date of commencement"; Rec."Date of commencement")
                {
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                }
                field("Tender no."; Rec."Tender no.")
                {
                }
                field("Contract Value"; Rec."Contract Value")
                {
                    ShowMandatory = true;
                }
                field("Provisional Sum"; Rec."Provisional Sum")
                {
                }
                field("Consultancy Fee"; Rec."Consultancy Fee")
                {
                    Enabled = false;
                }
                field("Contractor Code"; Rec."Contractor Code")
                {
                    trigger OnValidate()
                    begin
                        Vendor.Reset;
                        Vendor.SetRange("No.", Rec."Contractor Code");
                        if Vendor.Find('-') then Rec."Contractor Name" := Vendor.Name;
                        Rec."Contractor Address" := Vendor.Address;
                    end;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                }
                field("Contractor Address"; Rec."Contractor Address")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = true;
                    Enabled = false;
                }
                field("Progress of Work"; Rec."Progress of Work")
                {
                }
            }
            field("Line No"; Rec."Line No")
            {
                Visible = false;
            }
            field("User ID"; Rec."User ID")
            {
            }
            part(Control1; "Schedule List")
            {
                ShowFilter = false;
                SubPageLink = "Contract No." = FIELD("Contract No.");
            }
        }
    }
    actions
    {
    }
    var
        Vendor: Record Vendor;
}
