report 50172 "Tender Committee Scores"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TenderCommitteeScores.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(TenderCommittees; "Tender Committees")
        {
            column(AppointmentNo; "Appointment No")
            {
            }
            column(CommitteeID; "Committee ID")
            {
            }
            column(CommitteeName; "Committee Name")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(TenderQuotationNo; "Tender/Quotation No")
            {
            }
            column(Title; Title)
            {
            }
            dataitem("Supplier Evaluation Header"; "Supplier Evaluation Header")
            {
                DataItemLink = "Committee No." = field("Appointment No");

                column(No_; "No.")
                {
                }
                column(Quote_No; "Quote No")
                {
                }
                column(Total_Score; "Total Score")
                {
                }
                column(User; User)
                {
                }
                dataitem("Supplier Evaluation Score"; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(Score_Parameter; "Score Parameter")
                    {
                    }
                    column(Score_Description; "Score Description")
                    {
                    }
                    column(Score; Score)
                    {
                    }
                    column(Supplier_Code; "Supplier Code")
                    {
                    }
                    column(Supplier_Name; GetSupplierName("Supplier Code"))
                    {
                    }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        ProspectRec: Record "Prospective Suppliers";

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.get(SupplierCode) then exit(ProspectRec.Name);
    end;
}
