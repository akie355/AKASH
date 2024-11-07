#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

typedef struct {
    int u, v; // Edge between u and v
} Edge;

typedef struct {
    int vertices; // Number of vertices
    int edges;    // Number of edges
    Edge edge[MAX_VERTICES]; // List of edges
} Graph;

int time = 0; // Global variable to keep track of discovery time

// Function prototypes
void addEdge(Graph* g, int u, int v);
void bridgeUtil(Graph* g, int u, int visited[], int disc[], int low[], int parent[]);
void findCutEdges(Graph* g);

int main() {
    Graph g;
    g.vertices = 5; // Example: Create a graph with 5 vertices
    g.edges = 0;

    // Add edges to the graph (example edges)
    addEdge(&g, 0, 1);
    addEdge(&g, 1, 2);
    addEdge(&g, 2, 0);
    addEdge(&g, 1, 3);
    addEdge(&g, 3, 4);

    printf("Cut edges in the graph are:\n");
    findCutEdges(&g);

    return 0;
}

// Function to add an edge to the graph
void addEdge(Graph* g, int u, int v) {
    g->edge[g->edges].u = u;
    g->edge[g->edges].v = v;
    g->edges++;
}

// A recursive function that finds and prints all bridges
void bridgeUtil(Graph* g, int u, int visited[], int disc[], int low[], int parent[]) {
    visited[u] = 1; // Mark the current node as visited
    disc[u] = low[u] = ++time; // Initialize discovery time and low value

    for (int i = 0; i < g->edges; i++) {
        if (g->edge[i].u == u || g->edge[i].v == u) {
            int v = (g->edge[i].u == u) ? g->edge[i].v : g->edge[i].u;

            if (!visited[v]) { // If v is not visited
                parent[v] = u;
                bridgeUtil(g, v, visited, disc, low, parent);

                // Check if the subtree rooted at v has a connection back to one of the ancestors of u
                low[u] = (low[u] < low[v]) ? low[u] : low[v];

                // If the lowest vertex reachable from subtree under v is below u in DFS tree,
                // then u-v is a bridge
                if (low[v] > disc[u]) {
                    printf("%d -- %d is a cut edge\n", u, v);
                }
            } else if (v != parent[u]) { // Update low value of u for parent function calls
                low[u] = (low[u] < disc[v]) ? low[u] : disc[v];
            }
        }
    }
}

// Function to find and print all cut edges in the graph
void findCutEdges(Graph* g) {
    int visited[MAX_VERTICES] = {0};
    int disc[MAX_VERTICES]; // Stores discovery times of visited vertices
    int low[MAX_VERTICES];  // Earliest visited vertex reachable
    int parent[MAX_VERTICES]; // Parent vertices in DFS tree

    for (int i = 0; i < g->vertices; i++) {
        visited[i] = 0;
        parent[i] = -1;
    }

    for (int i = 0; i < g->vertices; i++) {
        if (!visited[i]) { // Call the recursive helper function to find Bridges
            bridgeUtil(g, i, visited, disc, low, parent);
        }
    }

    // If no cut edges were found:
}

